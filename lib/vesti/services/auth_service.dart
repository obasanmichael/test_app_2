import 'package:dio/dio.dart';
import 'package:test_app_2/vesti/services/api_services.dart';

Future<String?> loginUser(String email, String password) async {
  var dio = Dio();

  String loginUrl =
      'http://syca-app-backend.eba-pe3mzmfm.us-east-1.elasticbeanstalk.com/api/v1/authentication/login';

  try {
    var response = await dio.post(
      loginUrl,
      data: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode! >= 200 || response.statusCode! <= 300) {
      var responseData = response.data;
      String token = responseData['token'];
      ApiCall.getInstance().setToken(token);
      return token;
    } else {
      print('Login failed: ${response.data['message']}');
      return null;
    }
  } catch (e) {
    print('Error occurred during login: $e');
    return null;
  }
}
