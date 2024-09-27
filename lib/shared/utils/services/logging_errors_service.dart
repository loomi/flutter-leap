import 'package:dio/dio.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class LoggingErrorsService {
  captureOnDioErrorRequestData(DioException e) async {
    await Sentry.captureException(
      e,
      withScope: (scope) async {
        await scope.setTag(
          'http.status_code',
          e.response?.statusCode.toString() ?? 'Unknown',
        );

        await scope.setContexts(
          'DioRequest',
          {
            'method': e.requestOptions.method,
            'url': e.requestOptions.uri.toString(),
            'body': e.requestOptions.data,
            'headers': e.requestOptions.headers
          },
        );

        await scope.setContexts(
          'DioResponse',
          {
            'status': e.response?.statusCode,
            'body': e.response?.data,
          },
        );
      },
    );
  }
}
