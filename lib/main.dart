import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:scaled_app/scaled_app.dart';

import 'app/app_module.dart';
import 'shared/components/offline_wrapper_component.dart';
import 'shared/components/scaled_app_wrapper_component.dart';
import 'shared/components/splash_screen.dart';
import 'shared/injector/get_it_injector.dart';
import 'shared/utils/app_global_context.dart';
import 'shared/utils/custom_colors.dart';
import 'shared/utils/setups/setup_flavors.dart';

void main() async {
  WidgetsBinding widgetsBinding =
      ScaledWidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  SetupFlavors setupFlavors = SetupFlavors();

  await setupFlavors.setup();

  AppModule(injector: GetItInjector()).registerAllDependencies();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      statusBarColor: CustomColors.black.withOpacity(0.2),
    ),
  );

  runApp(const AppWidget());
}

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) async {
    _AppWidgetState? state = context.findAncestorStateOfType<_AppWidgetState>();
    if (state != null) state.changeLanguage(newLocale);
  }

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  Locale? _locale;

  changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityAppWrapper(
      app: MaterialApp(
        navigatorKey: GlobalAppContext.appKey,
        title: 'Flutter Leap V2',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: CustomColors.primary,
        ),
        home: const SplashScreen(),
        routes: AppModule().routes,
        builder: (buildContext, child) {
          return OfflineWrapperComponent(
            child: ScaledAppWrapper(
              child: child ?? Container(),
            ),
          );
        },
        locale: _locale,
      ),
    );
  }
}
