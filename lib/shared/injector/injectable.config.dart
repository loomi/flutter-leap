// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../app/modules/home_module/domain/repositories/i_example_repository.dart'
    as _i1012;
import '../../app/modules/home_module/domain/usecases/get_example_uc.dart'
    as _i806;
import '../../app/modules/home_module/domain/usecases/intefaces/i_get_example_uc.dart'
    as _i628;
import '../../app/modules/home_module/external/datasources/example_datasource.impl.dart'
    as _i449;
import '../../app/modules/home_module/infra/datasources/example_datasource.dart'
    as _i1066;
import '../../app/modules/home_module/infra/repositories/example_repository.impl.dart'
    as _i810;
import '../../app/modules/home_module/presenter/stores/example_store.dart'
    as _i387;
import '../auth/http_client_interface.dart' as _i783;
import '../utils/dio_config.dart' as _i887;
import 'injectable.dart' as _i1027;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.singleton<_i887.DioConfig>(() => registerModule.dioConfig);
    gh.singleton<_i361.Dio>(() => registerModule.dio);
    gh.singleton<_i783.HttpClientInterface>(() => registerModule.httpClient);
    gh.lazySingleton<_i387.ExampleStore>(() => _i387.ExampleStore());
    gh.lazySingleton<_i1066.ExampleDatasource>(() =>
        _i449.ExampleDatasourceImpl(
            httpClient: gh<_i783.HttpClientInterface>()));
    gh.lazySingleton<_i628.IGetExampleUseCase>(() => _i806.GetExampleUseCase());
    gh.lazySingleton<_i1012.IExampleRepository>(() =>
        _i810.ExampleRepositoryImpl(
            exampleDatasource: gh<_i1066.ExampleDatasource>()));
    return this;
  }
}

class _$RegisterModule extends _i1027.RegisterModule {}
