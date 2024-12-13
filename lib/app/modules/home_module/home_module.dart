import 'package:flutter/material.dart';

import '../../../shared/common/default_module.dart';
import '../../../shared/common/route_module.dart';

import 'presenter/pages/home_screen.dart';
import 'presenter/pages/home_screen_middleware.dart';

class HomeModule implements DefaultModule {
  final HomeRouteModule _routeModule = HomeRouteModule();

  @override
  Map<String, WidgetBuilder> get routes => _routeModule.routes;

  @override
  RouteModule get routeModule => _routeModule;
}

class HomeRouteModule implements RouteModule {
  @override
  Map<String, WidgetBuilder> get routes => {
        HomeScreen.routeName: (_) => const HomeScreen(),
        HomeScreenMiddleware.routeName: (_) => const HomeScreenMiddleware(),
        // outras possíveis rotas aqui...
      };
}
