import 'package:package_info_plus/package_info_plus.dart';

class SetupFlavors {
  static final SetupFlavors _setupFlavors = SetupFlavors._internal();

  factory SetupFlavors() {
    return _setupFlavors;
  }

  SetupFlavors._internal();

  String baseUrl = "";

  Future<void> setup() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    if (packageInfo.packageName.contains("homolog")) {
      baseUrl = "";
    } else if (packageInfo.packageName.contains("staging")) {
      baseUrl = "";
    } else {
      baseUrl = "";
    }
  }
}
