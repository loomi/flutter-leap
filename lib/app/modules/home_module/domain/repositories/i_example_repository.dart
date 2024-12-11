import 'package:result_dart/result_dart.dart';

import 'package:flutter_leap_v2/app/modules/home_module/domain/errors/errors.dart';
import 'package:flutter_leap_v2/app/modules/home_module/infra/models/example_model.dart';

abstract class IExampleRepository {
  AsyncResult<ExampleModel, ExampleError> getExample();
}
