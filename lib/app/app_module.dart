import 'package:flutter/material.dart';

import '../shared/common/default_module.dart';
import '../shared/injector/i_dependency_injector.dart';

import 'modules/home_module/home_module.dart';

class AppModule {
  final List<DefaultModule> _registeredModules = [
    HomeModule(),
  ];

  final IDependencyInjector? injector;

  AppModule({this.injector});

  Map<String, WidgetBuilder> get routes {
    final Map<String, WidgetBuilder> routes = {};
    for (var module in _registeredModules) {
      routes.addAll(module.routes);
    }
    return routes;
  }

  void registerAllDependencies() {
    for (var module in _registeredModules) {
      module.registerDependencies(injector);
    }
  }
}
