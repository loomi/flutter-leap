import 'package:flutter/material.dart';

import 'package:flutter_leap/src/utils/custom_colors.dart';
import 'package:flutter_leap/src/utils/localization/app_localizations.dart';

import '../widgets/bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

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
              child: IndexedStack(
                index: _currentIndex,
                children: [
                  Container(
                    color: Colors.red.withOpacity(0.3),
                    child: Center(
                      child: Text(L10N.of(context)!.helloWorld),
                    ),
                  ),
                  LocalizationOverride(
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
                  LocalizationOverride(
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
