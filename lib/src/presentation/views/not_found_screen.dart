import 'package:flutter/material.dart';
import 'package:loomi_flutter_boilerplate/src/utils/fonts.dart';

class NotFoundScreen extends StatefulWidget {
  const NotFoundScreen({Key? key}) : super(key: key);

  @override
  State<NotFoundScreen> createState() => _NotFoundScreenState();
}

class _NotFoundScreenState extends State<NotFoundScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "404",
              style: Fonts.headline2,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Página não encontrada",
              style: Fonts.headline5,
            ),
          ],
        ),
      ),
    );
  }
}
