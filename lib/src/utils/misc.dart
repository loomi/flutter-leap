import 'dart:developer';
import 'package:dio/dio.dart';

void printException(String identifier, e, s) {
  log(identifier);
  if (e is DioError) {
    log("${e.requestOptions.baseUrl}${e.requestOptions.path}");
    log(e.response.toString());
    log(e.error);
  }
  log(e.toString());
  log(s.toString());
}
