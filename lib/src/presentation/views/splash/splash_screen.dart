import 'package:flutter/material.dart';
import 'package:loomi_flutter_boilerplate/src/presentation/views/example_screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:loomi_flutter_boilerplate/src/utils/custom_colors.dart';
import 'package:loomi_flutter_boilerplate/src/utils/fonts.dart';
import '../../../utils/authentication.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static String routeName = "/splash-screen";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
          Navigator.pushNamed(context, ExampleScreen.routeName);
          removeNativeSplash();
        } else {
          //Navigator.pushNamed(context, <YOUR-AUTH-SCREEN>.routeName); //TODO
          Navigator.pushNamed(context, ExampleScreen.routeName);
          removeNativeSplash();
        }
      } catch (e) {
        //Navigator.pushNamed(context, <YOUR-AUTH-SCREEN>.routeName); //TODO
        Navigator.pushNamed(context, ExampleScreen.routeName);
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

  // ADD THIS WHEN ADDING FIREBASE MESSAGING, IF NOT, REMOVE IT

  // NotificationService().setup().then((value) {
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     firebaseCloudMessagingListeners();
  //   });
  // });

  // void firebaseCloudMessagingListeners() async {
  //   NotificationService.onMessage.listen(
  //     (RemoteMessage? message) {
  //       NotificationService().invokeLocalNotification(message!);
  //     },
  //   );
  // }
}
