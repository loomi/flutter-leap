import 'package:flutter_leap_v2/app/modules/home_module/infra/models/example_model.dart';

abstract class IExampleRepository {
  Future<ExampleModel> getExample();
}
