// class YourModule implements DefaultModule {
//   final YourRouteModule _routeModule = YourRouteModule();

//   @override
//   Map<String, WidgetBuilder> get routes => _routeModule.routes;

//   @override
//   void registerDependencies(IDependencyInjector? injector) {
//     injector?.registerSingleton<ExampleStore>(ExampleStore());
//     // outras dependencias aqui...
//   }

//   @override
//   RouteModule get routeModule => _routeModule;
// }

// class YourRouteModule implements RouteModule {
//   @override
//   Map<String, WidgetBuilder> get routes => {
//         YourScreen.routeName: (_) => const YourScreen(),
//         // outras possíveis rotas aqui...
//       };
// }
