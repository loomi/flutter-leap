import 'package:dio/dio.dart';
import 'package:loomi_flutter_boilerplate/src/utils/env.dart';

const JSON_HEADER = "Content-Type:application/json";

const JSON_HEADER_MULTIPART = "Content-Type:multipart/form-data";

class DioConfig {
  static final DioConfig _instance = DioConfig.internal();

  factory DioConfig() => _instance;

  DioConfig.internal();

  final _dio = Dio();
  final String _baseUrl = BASE_URL;

  get dio {
    BaseOptions options = BaseOptions(
      baseUrl: _baseUrl,
    );

    _dio.options.baseUrl = _baseUrl;
    _dio.options.connectTimeout = 50000; //5s
    _dio.options.receiveTimeout = 30000;
    _dio.interceptors.add(CustomInterceptors());
    return _dio;
  }
}

class CustomInterceptors extends InterceptorsWrapper {
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final auth = await Authentication.authenticated();
    if (auth) {
      final token = await Authentication.getToken();
      options.headers["Authorization"] = "Bearer $token";
    }
    options.headers["Accept"] = "application/json";
    return super.onRequest(options, handler);
  }
}
