import 'package:loomi_flutter_boilerplate/src/external/models/example.dart';

abstract class IExampleRepository {
  Future<Example> getExample();
}
