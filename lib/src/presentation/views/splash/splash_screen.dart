import 'package:flutter/material.dart';
import 'package:loomi_flutter_boilerplate/src/presentation/views/example_screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:loomi_flutter_boilerplate/src/utils/custom_colors.dart';
import 'package:loomi_flutter_boilerplate/src/utils/fonts.dart';
import 'package:loomi_flutter_boilerplate/src/utils/helpers/navigation_helper.dart';
import '../../../utils/authentication.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static String routeName = "/";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with NavigationService {
  removeNativeSplash() {
    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      FlutterNativeSplash.remove();
    });
  }

  @override
  void didChangeDependencies() async {
    Future.delayed(const Duration(milliseconds: 1500)).then((value) async {
      try {
        var authenticated = await Authentication.authenticated();
        if (authenticated) {
          pushReplacementNamed(ExampleScreen.routeName);
          removeNativeSplash();
        } else {
          //pushReplacementNamed( <YOUR-AUTH-SCREEN>.routeName); //TODO
          pushReplacementNamed(ExampleScreen.routeName);
          removeNativeSplash();
        }
      } catch (e) {
        //pushReplacementNamed( <YOUR-AUTH-SCREEN>.routeName); //TODO
        pushReplacementNamed(ExampleScreen.routeName);
        removeNativeSplash();
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: CustomColors.grey,
        width: double.infinity,
        height: double.infinity,
        //TODO: YOUR SPLASH SCREEN IMAGE HERE. IT WILL BE BEHIND THE NATIVE, IN CASE IT ENDS WITH PROBLEM, TO HAVE SOMETHING TO SHOW
        child: Center(
          child: Text(
            "SPLASH SCREEN",
            style: Fonts.headline1.copyWith(
              color: CustomColors.black,
            ),
          ),
        ),
      ),
    );
  }
}
