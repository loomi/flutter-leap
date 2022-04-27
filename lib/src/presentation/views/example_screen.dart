import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../stores/example_store.dart';
import '../widgets/example_text.dart';

class ExampleScreen extends StatefulWidget {
  const ExampleScreen({Key? key}) : super(key: key);

  static const routeName = "example_screen";

  @override
  _ExampleScreenState createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  final exampleStore = GetIt.I.get<ExampleStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Example title"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: const ExampleText(),
      ),
    );
  }
}
