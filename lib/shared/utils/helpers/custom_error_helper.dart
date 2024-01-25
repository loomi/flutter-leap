import 'package:flutter/widgets.dart';

import 'package:dio/dio.dart';

import 'show_confirmation_dialog_helper.dart';

void customErrorHelper(
  BuildContext context, {
  required e,
}) async {
  if (e is DioException) {
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
  } else {
    showConfirmationDialogHelper(
      body: "Ocorreu um erro inesperado.",
      confirmButtonText: 'OK',
      context: context,
      title: 'Erro',
    );
  }
}
