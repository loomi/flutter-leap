import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:loomi_flutter_boilerplate/src/utils/helpers/navigation_helper.dart';

import '../stores/example_store.dart';
import '../widgets/example_text.dart';

class ExampleScreen extends StatefulWidget {
  const ExampleScreen({Key? key}) : super(key: key);

  static const routeName = "/example_screen";

  @override
  _ExampleScreenState createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> with NavigationService {
  final exampleStore = GetIt.I.get<ExampleStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Example title"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: const ExampleText(),
      ),
    );
  }
}
