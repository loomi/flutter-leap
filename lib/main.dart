import 'package:flutter/material.dart';
import 'package:loomi_flutter_boilerplate/src/presentation/views/example_screen.dart';
import 'package:loomi_flutter_boilerplate/src/utils/custom_colors.dart';
import 'package:loomi_flutter_boilerplate/src/utils/routes.dart';
import 'package:loomi_flutter_boilerplate/src/utils/setups/setup_flavors.dart';
import 'package:loomi_flutter_boilerplate/src/utils/setups/setup_get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SetupFlavors setupFlavors = SetupFlavors();
  await setupFlavors.setup();
  setupGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: CustomColors.primary,
      ),
      home: const ExampleScreen(),
      routes: routes,
    );
  }
}
