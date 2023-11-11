import 'package:dio/dio.dart';

class DioHelper {
  final Dio _dio;

  DioHelper({String baseUrl = ""})
      : _dio = Dio(BaseOptions(
            baseUrl: baseUrl,
            sendTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
            connectTimeout: const Duration(seconds: 30)));

  Future<Response<dynamic>> post(
      {required String url, Map<String, dynamic>? data}) async {
    final response = await _dio.post(url, data: data);

    if (response.statusCode == 201 || response.statusCode == 200) {
      return response;
    } else {
      throw Exception("Failed With Status Code ${response.statusCode}");
    }
  }

  Future<Response<dynamic>> get(
      {required String url, Map<String, dynamic>? data}) async {
    final response = await _dio.get(url, data: data);

    if (response.statusCode == 201 || response.statusCode == 200) {
      return response;
    } else {
      throw Exception("Failed With Status Code ${response.statusCode}");
    }
  }
}
