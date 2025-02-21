import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'package:flutter_leap_v2/shared/utils/theme/app_colors_theme.dart';

import 'app_global_context.dart';
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
      color: appColors.black,
    ),
  ),
  behavior: SnackBarBehavior.floating,
  showCloseIcon: true,
  closeIconColor: appColors.white,
  duration: const Duration(seconds: 3),
  backgroundColor: appColors.white,
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
