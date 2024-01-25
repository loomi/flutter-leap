import 'package:get_it/get_it.dart';

import '../../infra/models/example_model.dart';
import '../repositories/i_example_repository.dart';

import 'intefaces/i_get_example_uc.dart';

class GetExampleUseCase implements IGetExampleUseCase {
  @override
  Future<ExampleModel> call() async {
    return GetIt.I.get<IExampleRepository>().getExample();
  }
}
