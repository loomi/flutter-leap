import 'package:flutter/material.dart';
import 'dart:async';

class GlobalAppContext {
  static final GlobalKey<NavigatorState> appKey = GlobalKey<NavigatorState>();

  static BuildContext get globalContext => appKey.currentState!.context;

  static void pop({Object? popObject}) {
    return appKey.currentState!.pop(popObject);
  }

  static Future<Object?> push(
    String routeName, {
    Object? arguments,
  }) async {
    return await appKey.currentState!.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  static void popUntil(String routeName) async {
    appKey.currentState!.popUntil(
      ModalRoute.withName(routeName),
    );
  }

  static Future<Object?> pushReplacement(
    String route, {
    String? popUntil,
    Object? arguments,
  }) async {
    return await appKey.currentState!.pushNamedAndRemoveUntil(
      route,
      popUntil == null
          ? (route) => route.isFirst
          : ModalRoute.withName(popUntil),
      arguments: arguments,
    );
  }

  static Future<Object?> pushReplacementNamed(String route,
      {Object? arguments}) async {
    return await appKey.currentState!.pushReplacementNamed(
      route,
      arguments: arguments,
    );
  }
}
