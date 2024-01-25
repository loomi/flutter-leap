import 'package:dio/dio.dart';

import '../app_global_context.dart';
import '../authentication.dart';
import '../misc.dart';

class DioErrorHelper {
  /// Handles 401 (Unauthorized) errors in HTTP requests.
  ///
  /// This method is responsible for handling 401 errors by either making a new
  /// request with the same options after the token is refreshed, redirecting
  /// the user to a specified route, executing an optional callback, or passing
  /// the error to the next handler for default error handling.
  ///
  /// Parameters:
  /// - [dio]: The Dio instance used for making requests.
  /// - [err]: The DioException representing the error.
  /// - [handler]: The error handler for interceptors.
  /// - [redirectRoute]: Optional - A route to redirect the user to.
  /// - [refreshedToken]: Optional - Indicates if a the request token was refreshed.

  static Future on401({
    required Dio? dio,
    required DioException err,
    required ErrorInterceptorHandler handler,
    String? redirectRoute,
  }) async {
    if (await Authentication.authenticated()) {
      // Usuário possui Token, mas teve problema pra autenticar,
      // Normalmente, é feita uma lógica aqui pra buscar novo token com RefreshToken,

      try {
        // Realiza aqui a lógica caso exista, e tenta novamente a chamada pra API, utilizando o RefreshToken.

        // Adiciona o header com o novo token
        // dio?.options.headers['Authorization'] =
        //     'Bearer $refreshToken';

        //Abaixo, é a lógica para retry da chamada, com o novo token

        final RequestOptions requestOptions = err.response!.requestOptions;

        var response = await dio?.request(
          requestOptions.path,
          data: requestOptions.data,
          queryParameters: requestOptions.queryParameters,
          options: Options(
            method: requestOptions.method,
            headers: requestOptions.headers,
          ),
        );
        return handler
            .resolve(response ?? Response(requestOptions: requestOptions));
      } catch (e) {
        // Caso não consiga, exclui o token do usuário, e redireciona pra alguma tela, se existir, usando GlobalAppContext.globalContext.

        if (redirectRoute != null) {
          GlobalAppContext.pushReplacementNamed(redirectRoute);
        }

        showUnauthSnackBar();

        Authentication.logout();

        return handler.next(err);
      }
    } else {
      if (redirectRoute != null) {
        GlobalAppContext.pushReplacementNamed(redirectRoute);
      }

      showUnauthSnackBar();

      return handler.next(err);
    }
  }
}
