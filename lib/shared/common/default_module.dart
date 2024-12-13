import 'package:flutter/material.dart';

import 'route_module.dart';

abstract class DefaultModule {
  Map<String, WidgetBuilder> get routes;
  RouteModule get routeModule;
}
