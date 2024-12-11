import 'package:dio/dio.dart';

abstract class HttpClientInterface {
  Future<Response> get(
    String url, {
    Map<String, dynamic>? headers,
  });

  Future<Response> post(
    String url, {
    Map<String, dynamic>? headers,
    dynamic body,
  });

  Future<Response> put(
    String url, {
    Map<String, dynamic>? headers,
    dynamic body,
  });

  Future<Response> delete(
    String url, {
    Map<String, dynamic>? headers,
  });
}
