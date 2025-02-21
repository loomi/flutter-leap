import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

import 'package:flutter_leap_v2/app/modules/home_module/presenter/stores/example_store.dart';
import 'package:flutter_leap_v2/shared/components/custom_snack_bar.dart';
import 'package:flutter_leap_v2/shared/utils/flavors_options.dart';
import 'package:flutter_leap_v2/shared/utils/theme/app_colors_theme.dart';
import 'package:flutter_leap_v2/shared/utils/theme/app_text_theme.dart';

import '../../../../../shared/components/bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/homeScreen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final pageViewController = PageController();

  final ExampleStore _exampleStore = GetIt.I.get<ExampleStore>();

  @override
  void didChangeDependencies() {
    log(_exampleStore.appState.toString());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.white,
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
                onPageChanged: (value) {
                  setState(() {
                    _currentIndex = value;
                  });
                },
                children: [
                  Container(
                    color: appColors.primary,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          FlavorsConfig().flavor.toString(),
                          style: currentTextStyles.headline,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.blue.withOpacity(0.3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          FlavorsConfig().flavor.toString(),
                          style: currentTextStyles.bodyText,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.green.withOpacity(0.3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          FlavorsConfig().flavor.toString(),
                          style: currentTextStyles.subtitle,
                        ),
                      ],
                    ),
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

  Future getExample() async {
    var result = await _exampleStore.getExample();

    result.onFailure(
      (failure) {
        showCustomSnackBar(
          context,
          textContent: failure.message,
        );
      },
    );
  }
}
