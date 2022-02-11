import 'package:get_it/get_it.dart';
import 'package:loomi_flutter_boilerplate/src/domain/repositories/i_example_repository.dart';
import 'package:loomi_flutter_boilerplate/src/domain/usecases/get_example_uc.dart';
import 'package:loomi_flutter_boilerplate/src/external/datasources/example_datasource.dart';
import 'package:loomi_flutter_boilerplate/src/presentation/stores/example_store.dart';
import 'package:loomi_flutter_boilerplate/src/presentation/usecases/i_get_example_uc.dart';
import 'package:loomi_flutter_boilerplate/src/utils/dio_config.dart';

void setupGetIt() {
  //Stores
  GetIt.I.registerSingleton<ExampleStore>(ExampleStore());

  //Datasources
  GetIt.I.registerSingleton<IExampleRepository>(
      ExampleDatasource(DioConfig().dio));

  //Usecases
  GetIt.I.registerSingleton<IGetExampleUseCase>(GetExampleUseCase());
}
