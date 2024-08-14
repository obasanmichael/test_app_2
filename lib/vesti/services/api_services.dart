import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiCall {
  static ApiCall _instance = ApiCall._internal();
  late Dio _dio;

  static String? token;
  static bool internetAvailable = true;

  ApiCall._internal([String? authToken = '']) {
    token = authToken;
    String t =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImNmNmM1MjBkLTQxMjktNDAzYi1iZDQ3LThlYTg4YmMyM2MyZiIsImVtYWlsIjoidGlib3ZhNTg3MkBldmltem8uY29tIiwiZmlyc3ROYW1lIjoiRWJlbmV6ZXIiLCJsYXN0TmFtZSI6Ikh1bnN1IiwiaWF0IjoxNzIzNjI1OTc4LCJleHAiOjE3MjM2Mjc3Nzh9.wwIFR5PydRxZy-bHvXezAHiqD6U9ILcnH4bBeh6TIbs";
    _dio = Dio();
    String _baseUrl =
        "http://syca-app-backend.eba-pe3mzmfm.us-east-1.elasticbeanstalk.com/api/v1";

    //_dio.options.headers
    _dio.options.responseType = ResponseType.json;
    _dio.options.headers["Accept"] = "*/*";
    _dio.options.baseUrl = _baseUrl;
    _dio.options.headers["Accept-Encoding"] = "gzip, deflate, br";
    _dio.options.headers["Authorization"] = 'Bearer $t ';

    _dio.options.connectTimeout = Duration(seconds: 30);
    if (!kReleaseMode) {
      _dio.interceptors.add(LogInterceptor(
        responseBody: true,
        requestBody: true,
      ));
    }
  }

  static ApiCall getInstance() {
    return _instance;
  }

  void reset(String? authToken) {
    _instance = ApiCall._internal(authToken);
  }

  void setToken(String? authToken) {
    _instance = ApiCall._internal(authToken);
  }

  Future<Response> postReq(
    String url, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? params,
    FormData? formData,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        url,
        data: data ?? formData,
        queryParameters: params,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getReq(
    String url, {
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: params,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> patchReq(
    String url, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? params,
    FormData? formData,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.patch(
        url,
        data: data ?? formData,
        queryParameters: params,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
