import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:loomi_flutter_boilerplate/src/presentation/stores/custom_loader_store.dart';

class CustomLoaderScreen extends StatefulWidget {
  const CustomLoaderScreen({Key? key}) : super(key: key);
  static String routeName = "/custom_loader_screen";

  @override
  State<CustomLoaderScreen> createState() => _CustomLoaderScreenState();
}

class _CustomLoaderScreenState extends State<CustomLoaderScreen> {
  final CustomLoaderStore _customLoaderStore = GetIt.I.get<CustomLoaderStore>();

  @override
  void didChangeDependencies() {
    Future.delayed(Duration.zero).then((value) async {
      if (_customLoaderStore.loaderCallback != null) {
        await _customLoaderStore.loaderCallback!();
      }
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: _customLoaderStore.backgroundGradient,
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft)),
              child: _customLoaderStore.backgroundImagePath.isNotEmpty
                  ? Image.asset(
                      _customLoaderStore.backgroundImagePath,
                    )
                  : Container(),
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //widget.body,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (_customLoaderStore.imagePath.isNotEmpty)
                        Image.asset(
                          _customLoaderStore.imagePath,
                          width: 84,
                          height: 84,
                        ),
                      const SizedBox(
                        height: 41,
                      ),
                      const Text(
                        "Aguarde!",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (_customLoaderStore.text.isNotEmpty)
                        Text(
                          _customLoaderStore.text,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      const SizedBox(
                        height: 30,
                      ),
                      const CircularProgressIndicator.adaptive(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
