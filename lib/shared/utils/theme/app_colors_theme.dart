import 'package:flutter/material.dart';

import 'package:flutter_leap_v2/shared/utils/app_global_context.dart';

abstract class AppColors {
  Color get primary;
  Color get secondary;
  Color get background;
  Color get text;
  Color get white;
  Color get black;
}

class AppColorsLight implements AppColors {
  @override
  Color get primary => HexColor("#ffffff");

  @override
  Color get secondary => HexColor("#ffffff");

  @override
  Color get background => HexColor("#ffffff");

  @override
  Color get text => HexColor("#000000");

  @override
  Color get black => Colors.black;

  @override
  Color get white => Colors.white;
}

class AppColorsDark implements AppColors {
  @override
  Color get primary => Colors.black.withOpacity(0.5);

  @override
  Color get secondary => const Color(0xFF64B5F6);

  @override
  Color get background => const Color(0xFF212121);

  @override
  Color get text => Colors.white;

  @override
  Color get black => Colors.black;

  @override
  Color get white => Colors.white;
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

AppColors get appColors {
  bool isDarkMode =
      MediaQuery.of(GlobalAppContext.globalContext).platformBrightness ==
          Brightness.dark;

  if (isDarkMode) {
    return AppColorsDark();
  } else {
    return AppColorsLight();
  }
}
