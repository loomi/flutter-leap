import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:package_info_plus/package_info_plus.dart';

enum FlavorsOptions { staging, production, homolog }

class SetupFlavors {
  static final SetupFlavors _setupFlavors = SetupFlavors._internal();

  factory SetupFlavors() {
    return _setupFlavors;
  }

  FlavorsOptions? currentFlavor;

  SetupFlavors._internal();

  Future<void> setup() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    if (kIsWeb) {
      if (const String.fromEnvironment("flavor").contains("staging")) {
        await dotenv.load(fileName: ".env.staging");
      } else {
        await dotenv.load(fileName: ".env.production");
      }
    } else {
      if (packageInfo.packageName.contains("homolog")) {
      } else if (packageInfo.packageName.contains("staging")) {
        await dotenv.load(fileName: ".env.staging");
      } else {
        await dotenv.load(fileName: ".env.production");
      }
    }
  }
}
