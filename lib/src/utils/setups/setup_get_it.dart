import 'package:get_it/get_it.dart';
import 'package:loomi_flutter_boilerplate/src/domain/usecases/get_paginated_example_uc.dart';
import 'package:loomi_flutter_boilerplate/src/presentation/stores/custom_loader_store.dart';
import 'package:loomi_flutter_boilerplate/src/presentation/usecases/i_get_paginated_example_uc.dart';

import '../../domain/repositories/i_example_repository.dart';
import '../../domain/usecases/get_example_uc.dart';
import '../../external/datasources/example_datasource.dart';
import '../../presentation/stores/example_store.dart';
import '../../presentation/usecases/i_get_example_uc.dart';
import '../dio_config.dart';

void setupGetIt() {
  //Stores
  GetIt.I.registerSingleton<ExampleStore>(ExampleStore());
  GetIt.I.registerSingleton<CustomLoaderStore>(CustomLoaderStore());
  //Datasources
  GetIt.I.registerSingleton<IExampleRepository>(
      ExampleDatasource(DioConfig().dio));

  //Usecases
  GetIt.I.registerSingleton<IGetExampleUseCase>(GetExampleUseCase());
  GetIt.I.registerSingleton<IGetPaginatedExampleUC>(GetPaginatedExampleUC());
}
