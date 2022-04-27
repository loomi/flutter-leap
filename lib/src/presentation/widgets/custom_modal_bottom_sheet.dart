import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'dart:io' show Platform;

import '../../utils/misc.dart';

// ignore: body_might_complete_normally_nullable
Future<bool?> showCustomModalBottomSheet(
  BuildContext context,
  Widget content, {
  Color backgroundColor = Colors.white,
}) async {
  try {
    await showModalBottomSheet<bool>(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, ss) {
            return Observer(
              builder: (context) {
                return Container(
                  padding: EdgeInsets.only(bottom: Platform.isIOS ? 32 : 8),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 20),
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Color(0xffE0E1E2),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          height: 4,
                          width: 45,
                        ),
                        content,
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  } catch (e, s) {
    printException('CustomModalBottomSheet', e, s);
  }
}
