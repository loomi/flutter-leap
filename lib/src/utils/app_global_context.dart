import 'package:flutter/material.dart';
import 'dart:async';

class GlobalAppContext {
  static final GlobalKey<NavigatorState> appKey = GlobalKey<NavigatorState>();

  static BuildContext get globalContext => appKey.currentState!.context;

  static void pop({Object? result}) {
    return appKey.currentState!.pop(result);
  }

  static Future<Object?> pushNamed(
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
    String routeName, {
    String? baseRoutename,
    Object? arguments,
  }) async {
    return await appKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      baseRoutename == null
          ? (route) => route.isFirst
          : ModalRoute.withName(baseRoutename),
      arguments: arguments,
    );
  }

  static Future<Object?> pushReplacementNamed(String routeName,
      {Object? arguments}) async {
    return await appKey.currentState!.pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }
}
