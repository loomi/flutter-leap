import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:loomi_flutter_boilerplate/src/presentation/views/splash/splash_screen.dart';
import 'src/utils/custom_colors.dart';
import 'src/utils/routes.dart';
import 'src/utils/setups/setup_flavors.dart';
import 'src/utils/setups/setup_get_it.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SetupFlavors setupFlavors = SetupFlavors();
  await setupFlavors.setup();
  setupGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ConnectivityAppWrapper(
      app: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: CustomColors.primary,
        ),
        home: const SplashScreen(),
        routes: routes,
        builder: (buildContext, widget) {
          return ConnectivityWidgetWrapper(
            child: widget!,
            disableInteraction: true,
            message: "Sem conexão com a internet",
            height: 60,
            // offlineWidget: const OfflineScreen(),
          );
        },
      ),
    );
  }
}
