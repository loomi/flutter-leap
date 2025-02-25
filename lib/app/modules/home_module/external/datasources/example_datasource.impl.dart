import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';

import 'package:flutter_leap_v2/app/modules/home_module/domain/errors/errors.dart';
import 'package:flutter_leap_v2/app/modules/home_module/infra/datasources/example_datasource.dart';
import 'package:flutter_leap_v2/shared/auth/http_client_interface.dart';

@LazySingleton(as: ExampleDatasource)
class ExampleDatasourceImpl implements ExampleDatasource {
  final HttpClientInterface httpClient;

  ExampleDatasourceImpl({required this.httpClient});

  @override
  AsyncResultDart<Map<String, dynamic>, ExampleError> getExample() async {
    try {
      var result = await httpClient.get(
        'todos/1',
      );

      return Success(result.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return Failure(ExampleError("Usuário não autenticado."));
      } else if (e.response?.statusCode == 500) {
        return Failure(ExampleError("Erro interno da API."));
      }

      return Failure(
        ExampleError("Ocorreu um erro inesperado."),
      );
    }
  }
}
