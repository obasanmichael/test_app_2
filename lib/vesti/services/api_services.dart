// services/api_service.dart

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_app_2/vesti/models/passport.dart';

class ApiService {
  final Dio _dio = Dio();

  getStatusCode(int code) {
    if (code >= 200 || code <= 300) {
      return true;
    } else {
      return false;
    }
    // switch (code) {
    //   case 200:
    //     return true;
    //   case 201:
    //     return true;
    //   default:
    // }
  }

  Future<Passport> uploadPassportImage({
    required String userId,
    required String firstName,
    required String lastName,
    required String passportNumber,
    required String dateOfBirth,
    required String expirationDate,
    required XFile passportImagePath,
  }) async {
    const String url = 'http://syca-app-backend.eba-pe3mzmfm.us-east-1.elasticbeanstalk.com/api/v1/identity-verification/upload-passport';

    FormData formData = FormData.fromMap({
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'passportNumber': passportNumber,
      'dateOfBirth': dateOfBirth,
      'expirationDate': expirationDate,
    });
    formData.files.add(
      MapEntry(
        'passportImagePath',
        MultipartFile.fromFileSync(passportImagePath.path,
            filename:
                passportImagePath.path.split(Platform.pathSeparator).last),
      ),
    );

    try {
      final response = await _dio.post(url,
          data: formData,
          options: Options(headers: {'Content-Type': 'multipart/form'}));
      if (response.statusCode! >= 200 || response.statusCode! <= 300) {
        return Passport.fromJson(response.data);
      } else {
        throw Exception('Failed to upload image');
      }
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }
}
