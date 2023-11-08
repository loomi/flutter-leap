import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_leap/src/presentation/views/home_screen.dart';
import 'package:flutter_leap/src/presentation/widgets/responsive_layout.dart';
import 'package:flutter_leap/src/utils/custom_colors.dart';

class HomeScreenMiddleware extends StatelessWidget {
  static const routeName = "/home";

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
