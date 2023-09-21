import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';

import 'package:flutter_leap/src/utils/environments.dart';
import 'package:flutter_leap/src/utils/misc.dart';

import 'authentication.dart';

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
    if (err.response?.statusCode == 401) {
      if (await Authentication.authenticated()) {
        // Usuário possui Token, mas teve problema pra autenticar,
        // Normalmente, é feita uma lógica aqui pra buscar novo token com RefreshToken,
        try {
          // Realiza aqui a lógica caso exista, e tenta novamente a chamada pra API, utilizando o RefreshToken.

          // Adiciona o header com o novo token
          // dio?.options.headers['Authorization'] =
          //     'Bearer $refreshToken';

          //Abaixo, é a lógica para retry da chamada, com o novo token

          final RequestOptions requestOptions = err.response!.requestOptions;

          return handler.resolve(
            await dio!.request(
              requestOptions.path,
              cancelToken: requestOptions.cancelToken,
              data: requestOptions.data,
              onReceiveProgress: requestOptions.onReceiveProgress,
              onSendProgress: requestOptions.onSendProgress,
              queryParameters: requestOptions.queryParameters,
            ),
          );
        } catch (e) {
          // Caso não consiga, exclui o token do usuário, e redireciona pra tela de login, se existir, usando GlobalAppContext.globalContext.

          showUnauthSnackBar();

          Authentication.logout();

          return handler.next(err);
        }
      } else {
        // Redireciona usuário pra tela de login, usando GlobalAppContext.globalContext.

        showUnauthSnackBar();
        return handler.next(err);
      }
    }

    return handler.next(err);
  }
}
