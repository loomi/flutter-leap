import 'package:result_dart/result_dart.dart';

import 'package:flutter_leap_v2/app/modules/home_module/domain/errors/errors.dart';

abstract class ExampleDatasource {
  AsyncResultDart<Map<String, dynamic>, ExampleError> getExample();
}
