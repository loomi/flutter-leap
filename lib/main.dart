import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leap/src/presentation/views/splash/splash_screen.dart';
import 'package:flutter_leap/src/utils/fonts.dart';
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
        title: 'Flutter Leap',
        theme: ThemeData(
          primaryColor: CustomColors.primary,
        ),
        home: const SplashScreen(),
        routes: routes,
        builder: (buildContext, widget) {
          return ConnectivityWidgetWrapper(
            child: widget!,
            disableInteraction: false,
            color: CustomColors.primary,
            alignment: Alignment.bottomCenter,
            offlineWidget: IgnorePointer(
              ignoring: true,
              child: SizedBox(
                height: 75,
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: CustomColors.black.withOpacity(0.75),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              color: CustomColors.white,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Sem conexão com a internet",
                              style: Fonts.headline5.copyWith(
                                color: CustomColors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
