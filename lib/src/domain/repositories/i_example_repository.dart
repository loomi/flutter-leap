import '../../external/models/example.dart';

abstract class IExampleRepository {
  Future<Example> getExample();
}
