import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DefaultErrorScreen extends StatelessWidget {
  final FlutterErrorDetails details;
  const DefaultErrorScreen({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              size: 48,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                kDebugMode
                    ? details.exception.toString()
                    : "Ocorreu um erro no carregamento da tela.\nPor favor entre em contato com a equipe responsável.",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
