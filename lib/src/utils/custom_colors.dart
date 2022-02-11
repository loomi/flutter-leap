import 'package:flutter/material.dart';

class CustomColors {
  static Color primary = HexColor("#ffffff");
  static Color white = HexColor("#ffffff");
  static Color black = HexColor("#000000");
  static Color grey = HexColor("#0d2C3B8B");
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
