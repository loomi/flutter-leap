import 'package:flutter/material.dart';

import 'package:connectivity_wrapper/connectivity_wrapper.dart';

import 'app/app_module.dart';
import 'shared/components/offline_wrapper_component.dart';
import 'shared/components/splash_screen.dart';
import 'shared/utils/app_global_context.dart';
import 'shared/utils/custom_colors.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

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
            child: child ?? Container(),
          );
        },
        locale: _locale,
      ),
    );
  }
}
