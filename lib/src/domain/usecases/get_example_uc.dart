import 'package:get_it/get_it.dart';
import 'package:loomi_flutter_boilerplate/src/domain/repositories/i_example_repository.dart';
import 'package:loomi_flutter_boilerplate/src/external/models/example.dart';
import 'package:loomi_flutter_boilerplate/src/presentation/usecases/i_get_example_uc.dart';

class GetExampleUseCase implements IGetExampleUseCase {
  @override
  Future<Example> call() async {
    return GetIt.I.get<IExampleRepository>().getExample();
  }
}
