import 'package:loomi_flutter_boilerplate/src/presentation/views/custom_loader_screen/custom_loader_screen.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
part 'custom_loader_store.g.dart';

class CustomLoaderStore = _CustomLoaderStoreBase with _$CustomLoaderStore;

abstract class _CustomLoaderStoreBase with Store {
  @observable
  String imagePath = "";

  @observable
  String backgroundImagePath = "";

  @observable
  String text = "";

  @observable
  List<Color> backgroundGradient = [];

  Function()? loaderCallback = () {};

  @action
  Future pushToCustomLoaderScreen(
      {required BuildContext context,
      String imagePath = "",
      String backgroundImagePath = "",
      List<Color> backgroundGradient = const [Colors.white, Colors.white],
      String text = "",
      required Function() loaderCallback}) async {
    this.imagePath = imagePath;
    this.backgroundImagePath = backgroundImagePath;
    this.text = text;
    this.backgroundGradient = backgroundGradient;
    this.loaderCallback = loaderCallback;
    Navigator.pushNamed(context, CustomLoaderScreen.routeName);
  }
}
