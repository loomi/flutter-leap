import 'package:flutter/material.dart';

import '../../../../../shared/components/responsive_layout.dart';
import '../../../../../shared/utils/custom_colors.dart';

import 'home_screen.dart';

class HomeScreenMiddleware extends StatelessWidget {
  static const routeName = "/homeMiddleware";

  const HomeScreenMiddleware({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      buildScreen: (baseSize) {
        switch (baseSize.name) {
          case "MOBILE":
            return const HomeScreen();
          case "DESKTOP":
            return Scaffold(
              backgroundColor: CustomColors.danger,
              body: Center(
                child: Container(
                  alignment: Alignment.center,
                  height: 500,
                  width: 500,
                  color: CustomColors.white,
                  child: const Text("500x500"),
                ),
              ),
            );
          default:
            return Container();
        }
      },
    );
  }
}
