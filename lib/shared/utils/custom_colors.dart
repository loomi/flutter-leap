import 'package:flutter/material.dart';

class CustomColors {
  static Color primary = HexColor("#ffffff");
  static Color secondary = HexColor("#ffffff");
  static Color textColor = HexColor("#000000");
  static Color white = HexColor("#ffffff");
  static Color black = HexColor("#000000");
  static Color success = HexColor("#60BC69");
  static Color danger = HexColor("#CA6363");
  static Color warning = HexColor("#DFC850");
  static Color grey10 = HexColor("#FAFAFA");
  static Color grey20 = HexColor("#F1F1F1");
  static Color grey60 = HexColor("#AEAEAE");
  static Color grey80 = HexColor("#555555");
  static Color grey100 = HexColor("#212121");
  static Color blank = HexColor("#CCCCCC");
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
