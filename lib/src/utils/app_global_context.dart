import 'package:flutter/material.dart';

class GlobalAppContext {
  static final GlobalKey<NavigatorState> appKey = GlobalKey<NavigatorState>();

  static BuildContext get globalContext => appKey.currentState!.context;

  static void pop() {
    appKey.currentState!.pop();
  }

  static void push(String routeName) {
    appKey.currentState!.pushNamed(routeName);
  }

  static void popUntil(String routeName) {
    appKey.currentState!.popUntil(
      ModalRoute.withName(routeName),
    );
  }

  static void pushReplacement(String route, {String? popUntil}) {
    appKey.currentState!.pushNamedAndRemoveUntil(
      route,
      popUntil == null
          ? (route) => route.isFirst
          : ModalRoute.withName(popUntil),
    );
  }

  static void pushReplacementNamed(String route) {
    appKey.currentState!.pushReplacementNamed(route);
  }
}
