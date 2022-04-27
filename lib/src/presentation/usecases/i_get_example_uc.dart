import '../../external/models/example.dart';

abstract class IGetExampleUseCase {
  Future<Example> call();
}
