import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../domain/repositories/i_example_repository.dart';
import '../models/example.dart';

part "example_datasource.g.dart";

@RestApi()
abstract class ExampleDatasource implements IExampleRepository {
  factory ExampleDatasource(Dio dio, {String baseUrl}) = _ExampleDatasource;

  @override
  @GET("/")
  Future<Example> getExample();
}
