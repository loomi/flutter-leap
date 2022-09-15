import 'package:loomi_flutter_boilerplate/src/presentation/views/custom_pin_code_screen/custom_pin_screen.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
part 'custom_pin_code_store.g.dart';

class CustomPinCodeStore = _CustomPinCodeStoreBase with _$CustomPinCodeStore;

abstract class _CustomPinCodeStoreBase with Store {
  @observable
  String code = "";

  @observable
  String title = "";

  @observable
  List<Color> bgGRadient = [];

  @observable
  bool loading = false;

  @observable
  int resendTime = 0;

  @action
  updateResendTime(int value) => resendTime = value;

  @observable
  int numberOfFields = 0;
  Function(dynamic value) confirmationCodeCallback = (dynamic value) {};
  Function() resendCodeButtonCallback = () {};
  Function() startScreenCodeCallback = () {};
  @action
  setCode(String value) => code = value;

  @action
  setPinCode(String value) => code = value;

  @action
  setLoading(bool value) => loading = value;

  @action
  Future pushToCustomPinCodeScreen({
    required BuildContext context,
    String title = "",
    List<Color> backgroundGradient = const [Colors.white, Colors.white],
    int resendTime = 60,
    required int numberOfFields,
    required Function(dynamic value) confirmationCodeCallback,
    required Function() resendConfirmationCodeCallback,
    required Function() startScreenCodeCallback,
  }) async {
    this.title = title;
    this.resendTime = resendTime;
    this.numberOfFields = numberOfFields;
    bgGRadient = backgroundGradient;
    this.confirmationCodeCallback = confirmationCodeCallback;
    resendCodeButtonCallback = resendConfirmationCodeCallback;
    this.startScreenCodeCallback = startScreenCodeCallback;

    Navigator.pushNamed(context, CustomPinScreen.routeName);
  }
}