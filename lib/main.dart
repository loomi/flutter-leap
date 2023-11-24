import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_leap/src/presentation/views/splash/splash_screen.dart';
import 'package:flutter_leap/src/presentation/widgets/offline_wrapper_component.dart';
import 'package:flutter_leap/src/utils/localization/app_localizations.dart';
import 'package:flutter_leap/src/utils/app_global_context.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
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

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      statusBarColor: CustomColors.black.withOpacity(0.2),
    ),
  );
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://1f99b34f8bb7ef3b0a4f5b96f79d2854@o4506281261858816.ingest.sentry.io/4506281291743232';
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(const MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) async {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    if (state != null) state.changeLanguage(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
        title: 'Flutter Leap',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: CustomColors.primary,
        ),
        home: const SplashScreen(),
        routes: routes,
        builder: (buildContext, child) {
          return OfflineWrapperComponent(
            child: child ?? Container(),
          );
        },
        locale: _locale,
        localizationsDelegates: L10N.localizationsDelegates,
        supportedLocales: L10N.supportedLocales,
      ),
    );
  }
}
