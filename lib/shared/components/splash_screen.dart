import 'package:flutter/material.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../../app/modules/home_module/presenter/pages/home_screen_middleware.dart';
import '../utils/authentication.dart';
import '../utils/custom_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static String routeName = "/splash-screen";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  removeNativeSplash() {
    FlutterNativeSplash.remove();
  }

  @override
  void didChangeDependencies() async {
    Future.delayed(const Duration(milliseconds: 10)).then((value) async {
      try {
        var authenticated = await Authentication.authenticated();
        if (authenticated) {
          Navigator.pushNamed(context, HomeScreenMiddleware.routeName);
          removeNativeSplash();
        } else {
          //TODO: Handle Unauthenticated Users
          Navigator.pushNamed(context, HomeScreenMiddleware.routeName);
          removeNativeSplash();
        }
      } catch (e) {
        //TODO: Handle When Fail to Check User Authentication
        Navigator.pushNamed(context, HomeScreenMiddleware.routeName);
        removeNativeSplash();
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: CustomColors.white,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }

  //TODO: If using FirebaseMessaing, uncomment this and call on initState, If not, REMOVE IT!

  // void notificationsSetup() {
  //   NotificationService().setup().then(
  //     (value) {
  //       FirebaseMessaging.instance.getInitialMessage().then(
  //         (message) {
  //           // FAZ ALGO SE O APP FOI ABERTO ATRAVÉS DA NOTIFICAÇÃO
  //         },
  //       );

  //       FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //         // EM QUALQUER MOMENTO QUE CHEGAR NOTIFICAÇÃO E O APP JÁ ESTIVER ABERTO, VAI INVOCAR A NOTIFICAÇÃO LOCAL
  //         NotificationService().invokeLocalNotification(message);
  //       });

  //       FirebaseMessaging.onMessageOpenedApp.listen(
  //         (RemoteMessage message) {
  //           // FAZ ALGO SE O APP ESTAVA APENAS "MINIMIZADO" E FOI ABERTO NOVAMENTE
  //         },
  //       );
  //     },
  //   );
  // }
}
