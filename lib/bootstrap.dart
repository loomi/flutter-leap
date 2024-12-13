import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'package:flutter_leap_v2/app/app_module.dart';
import 'package:flutter_leap_v2/shared/components/default_error_screen.dart';

import 'package:flutter_leap_v2/shared/utils/flavors_options.dart';

import 'app_widget.dart';
import 'shared/injector/injectable.dart';
import 'shared/utils/custom_colors.dart';

void bootstrap({
  required FlavorsOptions flavor,
  required String sentryUrlDsn,
}) async {
  await runZonedGuarded(
    () async {
      WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

      FlavorsConfig.initialize(flavor);

      configureDependencies();

      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          statusBarColor: CustomColors.black.withOpacity(0.2),
        ),
      );

      await SentryFlutter.init(
        (options) {
          options
            ..dsn = sentryUrlDsn
            ..tracesSampleRate = 1.0
            ..profilesSampleRate = 1.0;
        },
      );

      customError();

      runApp(const AppWidget());
    },
    (error, stackTrace) async {
      await Sentry.captureException(
        error,
        stackTrace: stackTrace,
      );
    },
  );
}

customError() {
  ErrorWidget.builder = (FlutterErrorDetails details) => DefaultErrorScreen(
        details: details,
      );
}
