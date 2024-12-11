import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';

import 'package:flutter_leap_v2/app/modules/home_module/domain/repositories/i_example_repository.dart';
import 'package:flutter_leap_v2/app/modules/home_module/infra/datasources/example_datasource.dart';
import 'package:flutter_leap_v2/app/modules/home_module/infra/models/example_model.dart';

import '../../domain/errors/errors.dart';

@LazySingleton(as: IExampleRepository)
class ExampleRepositoryImpl implements IExampleRepository {
  final ExampleDatasource exampleDatasource;

  ExampleRepositoryImpl({required this.exampleDatasource});

  @override
  AsyncResult<ExampleModel, ExampleError> getExample() async {
    final result = await exampleDatasource.getExample();

    return result.fold(
      (success) {
        return Success(ExampleModel.fromJson(success));
      },
      (failure) {
        return Failure(failure);
      },
    );
  }
}
