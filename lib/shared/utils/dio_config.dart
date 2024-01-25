import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';

import 'authentication.dart';
import 'environments.dart';
import 'helpers/dio_error_helper.dart';

// ignore: constant_identifier_names
const JSON_HEADER = "Content-Type:application/json";

// ignore: constant_identifier_names
const JSON_HEADER_MULTIPART = "Content-Type:multipart/form-data";

class DioConfig {
  static final DioConfig _instance = DioConfig.internal();

  factory DioConfig() => _instance;

  DioConfig.internal();

  final String _baseUrl = Environments.baseUrl;

  Dio? _dio;

  CustomInterceptors? _customInterceptors;

  void initializeDio() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
      ),
    );

    _customInterceptors = CustomInterceptors(_dio!);

    _dio?.interceptors.add(_customInterceptors!);

    _dio?.interceptors.add(
      RetryInterceptor(
        dio: _dio!,
        logPrint: log,
        retries: 3,
        retryDelays: const [
          Duration(seconds: 1),
          Duration(seconds: 2),
          Duration(seconds: 3),
        ],
      ),
    );
  }

  Dio get dio {
    if (_dio == null) {
      initializeDio();
    }
    return _dio!;
  }
}

class CustomInterceptors extends InterceptorsWrapper {
  final Dio? dio;

  CustomInterceptors(this.dio);

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

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    switch (err.response?.statusCode) {
      case 401:
        return DioErrorHelper.on401(dio: dio, err: err, handler: handler);
      default:
        return handler.next(err);
    }
  }
}
