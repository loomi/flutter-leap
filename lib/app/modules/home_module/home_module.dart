import 'package:flutter/material.dart';

import '../../../shared/common/default_module.dart';
import '../../../shared/injector/i_dependency_injector.dart';
import '../../../shared/common/route_module.dart';

import 'domain/usecases/get_example_uc.dart';
import 'domain/usecases/intefaces/i_get_example_uc.dart';
import 'presenter/pages/home_screen.dart';
import 'presenter/pages/home_screen_middleware.dart';
import 'presenter/stores/example_store.dart';

class HomeModule implements DefaultModule {
  final HomeRouteModule _routeModule = HomeRouteModule();

  @override
  Map<String, WidgetBuilder> get routes => _routeModule.routes;

  @override
  void registerDependencies(IDependencyInjector? injector) {
    injector?.registerSingleton<ExampleStore>(ExampleStore());
    injector?.registerSingleton<IGetExampleUseCase>(GetExampleUseCase());
    // outras dependencias aqui...
  }

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
