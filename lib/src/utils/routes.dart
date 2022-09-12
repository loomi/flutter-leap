import 'package:flutter/material.dart';
import 'package:loomi_flutter_boilerplate/src/presentation/views/custom_loader_screen/custom_loader_screen.dart';
import 'package:loomi_flutter_boilerplate/src/presentation/views/example_screen.dart';
import 'package:loomi_flutter_boilerplate/src/presentation/views/splash/splash_screen.dart';
import 'package:loomi_flutter_boilerplate/src/utils/helpers/navigation_helper.dart';
import 'package:routemaster/routemaster.dart';
import '../presentation/views/not_found_screen.dart';

final routemaster = RoutemasterDelegate(
  routesBuilder: (context) => routes,
  observers: [
    RouteObserverHelper(),
  ],
);

final routes = RouteMap(
  onUnknownRoute: (route) {
    return const MaterialPage(
      child: NotFoundScreen(),
    );
  },
  routes: {
    SplashScreen.routeName: (_) => const MaterialPage(child: SplashScreen()),
    ExampleScreen.routeName: (_) => const MaterialPage(child: ExampleScreen()),
    CustomLoaderScreen.routeName: (_) =>
        const MaterialPage(child: CustomLoaderScreen()),
  },
);

//TODO: TO USE WHEN HAVING AUTH FLOW ON THE APP
// final loggedOutRouteMap = RouteMap(
//   onUnknownRoute: (route) {
//     return const MaterialPage(
//       child: NotFoundScreen(),
//     );
//   },
//   routes: {
//     '/': (_) => MaterialPage(child: LoginPage()),
//   },
// );

// Example: Page with Query Params
// ExampleWithParam.routeName: (route) => MaterialPage(
//          child: ExampleWithParam(
//            id: route.queryParameters['id'] ?? "0",
//          ),
//        ),

// Example: Page with Path Params
// Example: Page with Query Params
// ExampleWithParam.routeName: (route) => MaterialPage(
//          child: ExampleWithParam(
//            id: route.pathParameters['id'] ?? "0",
//          ),
//        ),


