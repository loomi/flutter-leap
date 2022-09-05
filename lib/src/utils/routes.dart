import 'package:flutter/material.dart';
import 'package:loomi_flutter_boilerplate/src/presentation/views/custom_loader_screen/custom_loader_screen.dart';
import 'package:loomi_flutter_boilerplate/src/presentation/views/custom_pin_code_screen/custom_pin_screen.dart';
import 'package:loomi_flutter_boilerplate/src/presentation/views/example_screen.dart';

final Map<String, WidgetBuilder> routes = {
  ExampleScreen.routeName: (_) => const ExampleScreen(),
  CustomLoaderScreen.routeName: (_) => const CustomLoaderScreen(),
  CustomPinScreen.routeName: (_) => const CustomPinScreen(),
};
