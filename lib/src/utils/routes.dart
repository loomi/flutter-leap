import 'package:flutter/material.dart';
import '../presentation/views/home_screen.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (_) => const HomeScreen(),
};
