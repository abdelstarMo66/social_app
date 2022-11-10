import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String? url,
    String? lang = 'en',
    String? token,
    Map<String, dynamic>? Query,
  }) async {
    dio!.options.headers = {
      'lang': '$lang',
      'Authorization': '$token',
      'Content-Type': 'application/json',
    };
    return await dio!.get(url!, queryParameters: Query);
  }

  static Future<Response> postData({
    required String? url,
    String? lang = 'en',
    String? token,
    required Map<String, dynamic>? Data,
  }) async {
    dio!.options.headers = {
      'lang': '$lang',
      'Authorization': '$token',
      'Content-Type': 'application/json',
    };
    return await dio!.post(
      url!,
      data: Data,
    );
  }

  static Future<Response> putData({
    required String? url,
    String? lang = 'en',
    String? token,
    Map<String, dynamic>? Query,
  }) async {
    dio!.options.headers = {
      'lang': '$lang',
      'Authorization': '$token',
      'Content-Type': 'application/json',
    };
    return await dio!.put(url!, queryParameters: Query);
  }
}
