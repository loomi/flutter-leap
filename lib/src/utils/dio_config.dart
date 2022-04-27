import 'package:dio/dio.dart';

import 'authentication.dart';
import 'setups/setup_flavors.dart';

// ignore: constant_identifier_names
const JSON_HEADER = "Content-Type:application/json";

// ignore: constant_identifier_names
const JSON_HEADER_MULTIPART = "Content-Type:multipart/form-data";

class DioConfig {
  static final DioConfig _instance = DioConfig.internal();
  static final SetupFlavors setupFlavors = SetupFlavors();

  factory DioConfig() => _instance;

  DioConfig.internal();

  final _dio = Dio();
  final String _baseUrl = setupFlavors.baseUrl;

  get dio {
    _dio.options.baseUrl = _baseUrl;
    _dio.options.connectTimeout = 50000; //5s
    _dio.options.receiveTimeout = 30000;
    _dio.interceptors.add(CustomInterceptors());
    return _dio;
  }
}

class CustomInterceptors extends InterceptorsWrapper {
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final auth = await Authentication.authenticated();
    if (auth) {
      final token = await Authentication.getToken();
      options.headers["Authorization"] = "Bearer $token";
    }
    options.headers["Accept"] = "application/json";
    return super.onRequest(options, handler);
  }
}
