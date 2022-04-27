import 'package:get_it/get_it.dart';

import '../../external/models/example.dart';
import '../../presentation/usecases/i_get_example_uc.dart';
import '../repositories/i_example_repository.dart';

class GetExampleUseCase implements IGetExampleUseCase {
  @override
  Future<Example> call() async {
    return GetIt.I.get<IExampleRepository>().getExample();
  }
}
