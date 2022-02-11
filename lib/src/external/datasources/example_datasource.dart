import 'package:dio/dio.dart';
import 'package:loomi_flutter_boilerplate/src/domain/repositories/i_example_repository.dart';
import 'package:loomi_flutter_boilerplate/src/external/models/example.dart';
import 'package:retrofit/retrofit.dart';

part "example_datasource.g.dart";

@RestApi()
abstract class ExampleDatasource implements IExampleRepository {
  factory ExampleDatasource(Dio dio, {String baseUrl}) = _ExampleDatasource;

  @override
  @GET("/")
  Future<Example> getExample();
}
