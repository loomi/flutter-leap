import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';

import 'package:flutter_leap_v2/app/modules/home_module/domain/errors/errors.dart';

import '../../infra/models/example_model.dart';
import '../repositories/i_example_repository.dart';

import 'intefaces/i_get_example_uc.dart';

@LazySingleton(as: IGetExampleUseCase)
class GetExampleUseCase implements IGetExampleUseCase {
  @override
  AsyncResult<ExampleModel, ExampleError> call() async {
    var result = await GetIt.I.get<IExampleRepository>().getExample();

    return result;
  }
}
