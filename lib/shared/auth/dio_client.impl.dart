import 'package:dio/dio.dart';

import 'package:flutter_leap_v2/shared/auth/http_client_interface.dart';

class DioClientImpl implements HttpClientInterface {
  final Dio _dio;

  DioClientImpl({Dio? dio}) : _dio = dio ?? Dio();

  @override
  Future<Response> get(String url, {Map<String, dynamic>? headers}) async {
    try {
      return await _dio.get(
        url,
        options: Options(
          headers: headers,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> post(String url,
      {Map<String, dynamic>? headers, dynamic body}) async {
    try {
      return await _dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> put(String url,
      {Map<String, dynamic>? headers, dynamic body}) async {
    try {
      return await _dio.put(
        url,
        data: body,
        options: Options(
          headers: headers,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> delete(String url, {Map<String, dynamic>? headers}) async {
    try {
      return await _dio.delete(
        url,
        options: Options(
          headers: headers,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}
