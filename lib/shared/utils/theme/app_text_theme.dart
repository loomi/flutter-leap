import 'package:flutter/material.dart';

import 'package:flutter_leap_v2/shared/utils/app_global_context.dart';

abstract class AppTextStyles {
  TextStyle get bodyText;
  TextStyle get headline;
  TextStyle get subtitle;
}

class AppTextStylesLight implements AppTextStyles {
  @override
  TextStyle get bodyText => const TextStyle(
        fontSize: 16,
        color: Colors.black,
      );

  @override
  TextStyle get headline => const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      );

  @override
  TextStyle get subtitle => const TextStyle(
        fontSize: 18,
        color: Colors.black87,
      );
}

class AppTextStylesDark implements AppTextStyles {
  @override
  TextStyle get bodyText => const TextStyle(
        fontSize: 16,
        color: Colors.white,
      );

  @override
  TextStyle get headline => const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      );

  @override
  TextStyle get subtitle => const TextStyle(
        fontSize: 18,
        color: Colors.white70,
      );
}

AppTextStyles get currentTextStyles {
  bool isDarkMode =
      MediaQuery.of(GlobalAppContext.globalContext).platformBrightness ==
          Brightness.dark;

  if (isDarkMode) {
    return AppTextStylesDark();
  } else {
    return AppTextStylesLight();
  }
}
