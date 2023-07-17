import 'package:dio/dio.dart';
import 'package:flutter_leap/src/utils/environments.dart';

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

  Dio? _dio;
  final String _baseUrl = Environments.baseUrl;

  get dio => _dio ??= Dio(
        BaseOptions(
          baseUrl: _baseUrl,
          connectTimeout: const Duration(seconds: 50),
          receiveTimeout: const Duration(seconds: 50),
        ),
      )..interceptors.add(
          CustomInterceptors(),
        );
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
