import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:photo_view/photo_view.dart';
import 'package:test_app_2/vesti/services/api_services.dart';
import 'package:test_app_2/vesti/widgets/upload_success.dart';

class PassportService {
  final BuildContext context;

  PassportService(this.context);

  Future<void> saveImage(String url) async {
    try {
      var response = await Dio().get(
        url,
        options: Options(responseType: ResponseType.bytes),
      );
      final directory = await getApplicationDocumentsDirectory();
      final downloadsDirectory = Directory('${directory.path}/Download');
      if (!downloadsDirectory.existsSync()) {
        downloadsDirectory.createSync();
      }
      final file = File('${downloadsDirectory.path}/passport_image.jpg');
      await file.writeAsBytes(response.data);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image saved to ${file.path}')),
      );
    } catch (e) {
      print('Error saving image: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Failed to save image')));
    }
  }

  void viewImage(String url) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          body: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: PhotoView(
              imageProvider: NetworkImage(url),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> shareImage(String url) async {
    try {
      var response = await Dio().get(
        url,
        options: Options(responseType: ResponseType.bytes),
      );

      final directory = await getTemporaryDirectory();

      final filePath = '${directory.path}/passport_image.jpg';
      final file = File(filePath);
      await file.writeAsBytes(response.data);

      final xFile = XFile(file.path);

      await Share.shareXFiles([xFile], text: 'Check out this passport image');

      print('Image shared from path: $filePath');
    } catch (e) {
      print('Error sharing image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to share image')),
      );
    }
  }

  Future<String?> fetchPassportImage() async {
    try {
      final response = await ApiCall.getInstance().getReq('/identity-verification/passport-image');
      return response.data['passportUrlImage'] as String?;
    } on DioException catch (e) {
      print("Error fetching image: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to fetch image'),
          backgroundColor: Colors.red.shade300,
          action: SnackBarAction(
            label: 'okay',
            textColor: Colors.white,
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ),
      );
      return null;
    }
  }
  
  Future<void> sendData(String imagePath) async {
    var file = await MultipartFile.fromFile(
      imagePath,
      filename: "passport_image.jpg",
    );

    var formData = FormData.fromMap({
      "passportPicture": file,
    });

    try {
      await ApiCall.getInstance()
          .postReq('/identity-verification/upload-passport', formData: formData);
      openUploadSuccessModal();
    } on DioException catch (e) {
      print("Error uploading image: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to upload image'),
          backgroundColor: Colors.red.shade300,
          action: SnackBarAction(
            label: 'okay',
            textColor: Colors.white,
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ),
      );
    }
  }

  void openUploadSuccessModal() {
    showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext bc) {
        return Wrap(children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
            ),
            child: UploadSucessModal(),
          )
        ]);
      },
    );
  }

  Future<void> updatePassportImage(String imagePath) async {
    // Check if the file exists
    final file = File(imagePath);
    if (!await file.exists()) {
      print('File does not exist at path: $imagePath');
      return;
    }

    final formData = FormData.fromMap({
      'passport_image': await MultipartFile.fromFile(imagePath),
    });

    try {
      final response = await ApiCall.getInstance().patchReq(
        '/identity-verification/passport-image',
        formData: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Passport image updated successfully');
      } else {
        print(
            'Failed to update passport image. Status code: ${response.statusCode}');
        print('Response data: ${response.data}');
      }
    } on DioException catch (e) {
      print('DioException caught: $e');
      if (e.response != null) {
        print('Error response data: ${e.response?.data}');
        print('Error status code: ${e.response?.statusCode}');
      }
    } catch (e) {
      print('Unexpected error: $e');
    }
  }
}
