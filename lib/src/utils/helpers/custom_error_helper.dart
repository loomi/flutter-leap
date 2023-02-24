import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:loomi_flutter_boilerplate/src/utils/helpers/show_confirmation_dialog_helper.dart';

void customErrorHelper(
  BuildContext context, {
  required e,
}) async {
  if (e is DioError) {
    if (e.response != null) {
      showConfirmationDialogHelper(
        body:
            // FORMATO PARA PEGAR ERRO DIRETO DA RESPONSE DA API, VAI DEPENDER DO FORMATO QUE CADA BACKEND RETORNAR
            e.response!.data['display_error'] ?? "Ocorreu um erro inesperado.",
        confirmButtonText: 'OK',
        context: context,
        title: 'Erro',
      );
    } else {
      showConfirmationDialogHelper(
        body: "Ocorreu um erro inesperado.",
        confirmButtonText: 'OK',
        context: context,
        title: 'Erro',
      );
    }
  }

  showConfirmationDialogHelper(
    body: "Ocorreu um erro inesperado.",
    confirmButtonText: 'OK',
    context: context,
    title: 'Erro',
  );
}
