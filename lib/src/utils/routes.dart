import 'package:flutter/material.dart';
import 'package:flutter_leap/src/presentation/views/home_screen/home_screen_middleware.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreenMiddleware.routeName: (_) => const HomeScreenMiddleware(),
};
