// import 'package:dio/dio.dart';
// import 'package:test_app_2/vesti/models/passport.dart';

// class PassportService {
//   final Dio _dio;
//   final String _baseUrl = 'http://syca-app-backend.eba-pe3mzmfm.us-east-1.elasticbeanstalk.com/api/v1';

//   PassportService([Dio? dio]) : _dio = dio ?? Dio();

//   // Endpoint for passport creation
//   String get _passportEndpoint => '$_baseUrl/identity-verification/upload-passport';

//   // Endpoint for uploading passport image
//   String get _uploadImageEndpoint => '$_baseUrl/identity-verification/upload-passport';

//   // Creates a passport and returns the created Passport object
//   Future<Passport> createPassport(Passport passport) async {
//     try {
//       final response = await _dio.post(
//         _passportEndpoint,
//         data: passport.toJson(),
//       );

//       // Check for successful response
//       if (response.statusCode == 200) {
//         return Passport.fromJson(response.data);
//       } else {
//         _handleError(response);
//       }
//     } on DioException catch (e) {
//       _handleError(e.response);
//     } catch (e) {
//       throw Exception('An unexpected error occurred: $e');
//     }

//     // Ensure that a Passport object is returned in case of errors
//     throw Exception('Failed to create passport');
//   }

//   // Uploads a passport image and returns the updated Passport object
//   Future<Passport> uploadPassportImage({

//     String passportImagePath,
//   }) async {
//     try {
//       final formData = FormData.fromMap({
//         ''
//        // 'passport_image': await MultipartFile.fromFile(passportImagePath),
//       });

//       final response = await _dio.post(
//         _uploadImageEndpoint,
//         data: formData,
//       );

//       // Check for successful response
//       if (response.statusCode == 200) {
//         return Passport.fromJson(response.data);
//       } else {
//         _handleError(response);
//       }
//     } on DioException catch (e) {
//       _handleError(e.response);
//     } catch (e) {
//       throw Exception('An unexpected error occurred: $e');
//     }

//     // Ensure that a Passport object is returned in case of errors
//     throw Exception('Failed to upload passport image');
//   }

//   // Handles errors based on the response
//   void _handleError(Response? response) {
//     final errorMessage = response != null
//         ? 'Error ${response.statusCode}: ${response.statusMessage}'
//         : 'An unexpected error occurred';
//     throw Exception(errorMessage);
//   }
// }
