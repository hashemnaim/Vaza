import 'package:dio/dio.dart';
import '../environment/environment.dart';
import 'storage_helper.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: BASE_URL,
        receiveDataWhenStatusError: true,
        followRedirects: false,
        sendTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        validateStatus: (status) {
          return status! <= 500;
        },
        headers: {
          'Content-Type': 'application/json',
          'API-KEY': 'AWRsdgdyr5tDFHDF435345werfTer3',
          "X-localization": StorageService.getcurrentLanguage(),
          'Authorization': 'Bearer ${StorageService.getToken()}'
        }));
  }

  static Future<Response> getData(
    String url, {
    Map<String, dynamic>? query,
  }) async {
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> postData(
    String url, {
    Map<String, dynamic>? data,
  }) async {
    return await dio!.post(url, data: data);
  }

  static Future<Response> postFormData(
    String url, {
    FormData? formData,
  }) async {
    return await dio!.post(url, data: formData);
  }

  static Future<Response> putData(
    String url, {
    Map<String, dynamic>? data,
  }) async {
    return await dio!.put(url, data: data);
  }

  static Future<Response> deleteData(
    String url, {
    Map<String, dynamic>? data,
  }) async {
    return await dio!.delete(url, data: data);
  }
}
