import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

import 'package:flutter_leap/src/utils/app_global_context.dart';
import 'package:flutter_leap/src/utils/custom_colors.dart';
import 'package:flutter_leap/src/utils/fonts.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> printException(String identifier, e, s) async {
  log(identifier);
  if (e is DioException) {
    log("${e.requestOptions.baseUrl}${e.requestOptions.path}");
    log(e.response.toString());
    log(e.error.toString());
  }
  log(e.toString());
  log(s.toString());
  await createSentryException(e, s);
}

Future<void> createSentryException(exception, stackTrace) async {
  await Sentry.captureException(
    exception,
    stackTrace: stackTrace,
  );
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

// ignore: non_constant_identifier_names
String SENTRY_ID =
    'https://1f99b34f8bb7ef3b0a4f5b96f79d2854@o4506281261858816.ingest.sentry.io/4506281291743232';
