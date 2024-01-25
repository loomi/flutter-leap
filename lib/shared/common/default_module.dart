import 'package:flutter/material.dart';

import '../injector/i_dependency_injector.dart';
import 'route_module.dart';

abstract class DefaultModule {
  Map<String, WidgetBuilder> get routes;
  void registerDependencies(IDependencyInjector? injector);
  RouteModule get routeModule;
}
