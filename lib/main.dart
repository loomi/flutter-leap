import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:loomi_flutter_boilerplate/src/data/datasources/example_datasource.dart';
import 'package:loomi_flutter_boilerplate/src/domain/usecases/get_example_uc.dart';
import 'package:loomi_flutter_boilerplate/src/presentation/views/example_screen.dart';
import 'package:loomi_flutter_boilerplate/src/utils/dio_config.dart';
import 'package:loomi_flutter_boilerplate/src/utils/setup_get_it.dart';

void main() {
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
        primarySwatch: Colors.blue,
      ),
      home: const ExampleScreen(),
    );
  }
}

