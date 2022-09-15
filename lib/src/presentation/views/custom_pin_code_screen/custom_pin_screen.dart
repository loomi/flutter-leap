import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:loomi_flutter_boilerplate/src/presentation/stores/custom_pin_code_store.dart';

class CustomPinScreen extends StatefulWidget {
  static String routeName = "/custom_pin_screen";

  const CustomPinScreen({Key? key}) : super(key: key);

  @override
  State<CustomPinScreen> createState() => _CustomPinScreenState();
}

class _CustomPinScreenState extends State<CustomPinScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController codeController = TextEditingController();
  Timer? _timer;
  int _start=0;
  final _pinCodeStore = GetIt.I.get<CustomPinCodeStore>();
  final _controller = ScrollController();

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {});
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  void initState() {
    _start=_pinCodeStore.resendTime;
    startTimer();
    _pinCodeStore.startScreenCodeCallback();
    super.initState();
  }

  void _animateToIndex(int index) {
    _controller.animateTo(
      index * 60,
      duration: Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: _pinCodeStore.bgGRadient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: _pinCodeStore.loading
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,
                    child: const Center(
                      child: CircularProgressIndicator.adaptive(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        .12),
                                child: Text(
                                  _pinCodeStore.title,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        .03),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 50,
                                ),
                                child: Text(
                                  "Fique atento e insira o código de ${_pinCodeStore.numberOfFields}\ndígitos aqui:",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: 16,
                                    height: 1.2,
                                  ),
                                ),
                              ),
                              Observer(builder: (context) {
                                return Container(
                                  margin: const EdgeInsets.only(top: 24),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14),
                                  child: SingleChildScrollView(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    controller: _controller,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 0,
                                          height: 0,
                                          child: TextField(
                                            focusNode: focusNode,
                                            autofocus: true,
                                            controller: codeController,
                                            onChanged: (value) async {
                                              await _pinCodeStore
                                                  .setCode(value);
                                              _animateToIndex(
                                                  _pinCodeStore.code.length);
                                              if (_pinCodeStore.code.length >=
                                                  _pinCodeStore
                                                      .numberOfFields) {
                                                FocusScope.of(context)
                                                    .unfocus();
                                                _pinCodeStore.setLoading(true);
                                                await _pinCodeStore
                                                    .confirmationCodeCallback(
                                                        value);
                                                _pinCodeStore.setLoading(false);
                                                codeController.clear();
                                                _pinCodeStore.setCode("");
                                              }
                                            },
                                            keyboardType: TextInputType.number,
                                          ),
                                        ),
                                        ...List.generate(
                                          _pinCodeStore.numberOfFields,
                                          (i) => GestureDetector(
                                            onTap: () {
                                              focusNode.requestFocus();
                                            },
                                            behavior:
                                                HitTestBehavior.translucent,
                                            child: Container(
                                              height: 60,
                                              width: 60,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              decoration: BoxDecoration(
                                                color: Colors.white
                                                    .withOpacity(.1),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: i ==
                                                        _pinCodeStore
                                                            .code.length
                                                    ? Border.all(
                                                        width: 2,
                                                        color: Colors.white,
                                                      )
                                                    : null,
                                              ),
                                              child: i + 1 <=
                                                      _pinCodeStore.code.length
                                                  ? Center(
                                                      child: Text(
                                                        _pinCodeStore
                                                            .code.characters
                                                            .elementAt(i),
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    )
                                                  : null,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                              Container(
                                margin: const EdgeInsets.only(top: 30),
                                child: _start != 0
                                    ? Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 30),
                                        child: Row(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  right: 20),
                                              child:
                                                  const CircularProgressIndicator
                                                      .adaptive(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(Colors.white),
                                              ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                "Vamos enviar um código novo em \naté $_start segundo${_start == 1 ? "" : "s"}...",
                                                maxLines: 2,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    height: 1.2),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(
                                        width: double.infinity,
                                        margin: const EdgeInsets.only(left: 30),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _start = 60;
                                              startTimer();
                                            });
                                            _pinCodeStore
                                                .resendCodeButtonCallback();
                                          },
                                          child: const Text(
                                            "Não recebi o código",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
