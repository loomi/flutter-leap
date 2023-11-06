import 'package:flutter/material.dart';
import 'package:flutter_leap/main.dart';

import 'package:flutter_leap/src/utils/custom_colors.dart';
import 'package:flutter_leap/src/utils/localization/app_localizations.dart';
import 'package:loomi_ui_flutter/widgets/custom_button.dart';

import '../widgets/bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final pageViewController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: PageView(
                controller: pageViewController,
                // index: _currentIndex,
                children: [
                  Container(
                    color: Colors.red.withOpacity(0.3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(L10N.of(context)!.helloWorld),
                        ),
                        CustomButton(
                          text: "Trocar",
                          onTap: () {
                            MyApp.setLocale(
                              context,
                              const Locale("es"),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  LocalizationOverriderBuilder(
                    languageCode: 'en',
                    builder: (context) {
                      return Container(
                        color: Colors.green.withOpacity(0.3),
                        child: Center(
                          child: Text(L10N.of(context)!.helloWorld),
                        ),
                      );
                    },
                  ),
                  LocalizationOverriderBuilder(
                    languageCode: 'es',
                    builder: (context) {
                      return Container(
                        color: Colors.blue.withOpacity(0.3),
                        child: Center(
                          child: Text(L10N.of(context)!.helloWorld),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomBottomNavigationBar(
                index: _currentIndex,
                onClick: (value) {
                  setState(() {
                    pageViewController.jumpToPage(
                      value,
                    );
                    _currentIndex = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
