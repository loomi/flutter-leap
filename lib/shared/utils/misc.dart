import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'app_global_context.dart';
import 'custom_colors.dart';
import 'fonts.dart';

void logException(String identifier, e, s) async {
  if (e is DioException) {
    log("${e.requestOptions.baseUrl}${e.requestOptions.path}");
    log(e.response.toString());
    log(e.error.toString());
  }
  await Sentry.captureException(
    e,
    stackTrace: s,
    withScope: (scope) {
      scope.setTag('error.identifier', identifier);
      scope.setContexts('error', {
        'message': e.toString(),
      });
    },
  );

  log(identifier);
  log(e.toString());
  log(s.toString());
}

final snackBar = SnackBar(
  content: Text(
    'Sessão finalizada, realize o login novamente.',
    style: Fonts.mobileBody1.copyWith(
      color: CustomColors.black,
    ),
  ),
  behavior: SnackBarBehavior.floating,
  showCloseIcon: true,
  closeIconColor: CustomColors.white,
  duration: const Duration(seconds: 3),
  backgroundColor: CustomColors.white,
  elevation: 12,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
  padding: const EdgeInsets.all(12),
  margin: const EdgeInsets.fromLTRB(
    20,
    0,
    20,
    20,
  ),
);

showUnauthSnackBar() {
  ScaffoldMessenger.of(GlobalAppContext.globalContext).showSnackBar(snackBar);
}

const Map<String, String> mapAccents = {
  'á': 'a',
  'à': 'a',
  'â': 'a',
  'ã': 'a',
  'ä': 'a',
  'é': 'e',
  'è': 'e',
  'ê': 'e',
  'ë': 'e',
  'í': 'i',
  'ì': 'i',
  'î': 'i',
  'ï': 'i',
  'ó': 'o',
  'ò': 'o',
  'ô': 'o',
  'õ': 'o',
  'ö': 'o',
  'ú': 'u',
  'ù': 'u',
  'û': 'u',
  'ü': 'u',
  'ç': 'c',
  'Á': 'A',
  'À': 'A',
  'Â': 'A',
  'Ã': 'A',
  'Ä': 'A',
  'É': 'E',
  'È': 'E',
  'Ê': 'E',
  'Ë': 'E',
  'Í': 'I',
  'Ì': 'I',
  'Î': 'I',
  'Ï': 'I',
  'Ó': 'O',
  'Ò': 'O',
  'Ô': 'O',
  'Õ': 'O',
  'Ö': 'O',
  'Ú': 'U',
  'Ù': 'U',
  'Û': 'U',
  'Ü': 'U',
  'Ç': 'C',
};
