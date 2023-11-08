import 'package:flutter/material.dart';
import 'package:scaled_app/scaled_app.dart';

class ScreenUtils {
  static final ScreenUtils _instance = ScreenUtils._internal();

  factory ScreenUtils() => _instance;

  ScreenUtils._internal();

  //set a max width for the app to scale to
  static const double? maxWidth = null;
  //set a max height for the app to scale to if you are using height scale as well
  static const double? maxHeight = null;

  //set to true if you want to use height scale
  static const bool useHeightScale = false;

  //Screen sizes used in the mockup
  //Use this to identify which screen layout you are using
  static final List<BaseSize> baseSizes = [
    BaseSize(
      name: "MOBILE",
      size: const Size(400, 700),
      threshold: 720,
    ),
    BaseSize(
      name: "DESKTOP",
      size: const Size(1920, 1080),
      threshold: double.infinity,
    ),
  ];

  //You can change how you get the current base size based on your needs
  //Usually you are going to use the width of the screen as a condition to determine the layout, so thats what I used here
  static BaseSize getCurrentBaseSize(Size screenSize) {
    BaseSize result = baseSizes.first;

    for (var baseSize in baseSizes) {
      if (screenSize.width < baseSize.threshold!) {
        result = baseSize;
        break;
      }
    }

    return result;
  }

  static setScale() {
    final binding = ScaledWidgetsFlutterBinding.instance;

    binding.scaleFactor = (deviceSize) {
      Size baseSize = getCurrentBaseSize(deviceSize).size;

      double deviceWidth = (maxWidth != null && deviceSize.width > maxWidth!)
          ? maxWidth!
          : deviceSize.width;
      double deviceHeight =
          (maxHeight != null && deviceSize.height > maxHeight!)
              ? maxHeight!
              : deviceSize.height;

      double widthScale = deviceWidth / baseSize.width;
      double heightScale = deviceHeight / baseSize.height;

      double minScale = useHeightScale
          ? widthScale < heightScale
              ? widthScale
              : heightScale
          : widthScale;

      return minScale;
    };
  }
}

class BaseSize {
  final String name;
  final Size size;

  //The threshold is an arbitrary double defined by you to represent a point where your app should interpret that the base size of the app needs to change
  final double? threshold;

  BaseSize({
    required this.name,
    required this.size,
    this.threshold,
  });
}
