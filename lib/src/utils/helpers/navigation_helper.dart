import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

import '../routes.dart';

class NavigationService {
  pop() {
    return routemaster.history.back();
  }

  push(String route, {Map<String, String>? queryParameters}) {
    return routemaster.push(route, queryParameters: queryParameters);
  }

  pushReplacementNamed(String route, {Map<String, String>? queryParameters}) {
    return routemaster.replace(
      route,
      queryParameters: queryParameters,
    );
  }
}

class RouteObserverHelper extends RoutemasterObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    log(routemaster.history.toString());
  }

  @override
  void didChangeRoute(RouteData routeData, Page page) {
    log(routemaster.history.toString());
  }
}
