
import 'package:dio/dio.dart';

void printException(String identifier, e, s){
  print(identifier);
  if (e is DioError) {
    print("${e.requestOptions.baseUrl}${e.requestOptions.path}");
    print(e.response);
    print(e.error);
  }
  print(e);
  print(s);
}