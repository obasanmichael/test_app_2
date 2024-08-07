import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app_2/vesti/services/api_services.dart';
import 'package:test_app_2/vesti/widgets/button.dart';
import 'package:test_app_2/vesti/widgets/outlined_button.dart';
import 'package:test_app_2/vesti/widgets/upload_success.dart';

class PassportReviewScreen extends StatefulWidget {
  const PassportReviewScreen({super.key, required this.imagePath});

  final String imagePath;

  @override
  State<PassportReviewScreen> createState() => _PassportReviewScreenState();
}

class _PassportReviewScreenState extends State<PassportReviewScreen> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    Widget addHeight(double height) => SizedBox(height: height.h);
    Widget addWidth(double width) => SizedBox(width: width.w);

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

    Future<void> sendData() async {
      var file = await MultipartFile.fromFile(
        widget.imagePath,
        filename: "passport_image.jpg",
      );

      var formData = FormData.fromMap({
        "passportPicture": file,
      });
      setState(() {
        _isLoading = true;
      });
      try {
        await ApiCall.getInstance().postReq(
            '/identity-verification/upload-passport',
            formData: formData);
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
                }),
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          'Passport Document',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.sp),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Review your Passport Photo',
              style: TextStyle(
                  color: Color(0xff518C36),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500),
            ),
            addHeight(16),
            Text(
              'Please ensure all the Information and details on the passport are clear and visible before uploading.',
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14.sp),
            ),
            addHeight(67),
            Container(
              height: 216.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(12.r),
                image: DecorationImage(
                  image: FileImage(File(widget.imagePath)),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            addHeight(80),
            MyButton(label: _isLoading? null : 'Photo is clear and visible', onPressed: _isLoading? null: sendData, child: _isLoading
                  ? CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.0,
                    )
                  : null,
            ),
            addHeight(13),
            MyOutlinedButton(
                label: 'Use another photo',
                onPressed: _isLoading? null : () {
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }
}
