import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_leap_v2/shared/utils/dio_config.dart';

import '../auth/dio_client.impl.dart';
import '../auth/http_client_interface.dart';

import 'injectable.config.dart';

final getIt = GetIt.instance;

@module
abstract class RegisterModule {
  // Registra DioConfig como Singleton
  @singleton
  DioConfig get dioConfig => DioConfig();

  // Registra Dio usando DioConfig
  @singleton
  Dio get dio => DioConfig().dio;

  // Registra o HttpClientInterface com a implementação baseada no Dio
  @singleton
  HttpClientInterface get httpClient => DioClientImpl(dio: dio);
}

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
void configureDependencies() => getIt.init();
