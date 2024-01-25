// route_module.dart
import 'package:flutter/material.dart';

abstract class RouteModule {
  Map<String, WidgetBuilder> get routes;
}
