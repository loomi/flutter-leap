import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';

import '../utils/custom_colors.dart';
import '../utils/misc.dart';

// ignore: body_might_complete_normally_nullable
Future<bool?> showCustomModalBottomSheet(
  BuildContext context,
  Widget content, {
  Color backgroundColor = Colors.white,
}) async {
  try {
    if (kIsWeb) {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.start,
            actionsOverflowDirection: VerticalDirection.up,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            insetPadding: const EdgeInsets.all(8),
            buttonPadding: EdgeInsets.zero,
            actionsPadding: EdgeInsets.zero,
            contentPadding: const EdgeInsets.only(
              top: 25,
            ),
            content: Stack(
              clipBehavior: Clip.none,
              children: [
                content,
                Positioned(
                  top: -10,
                  right: 5,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.close,
                      color: CustomColors.secondary,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    } else {
      await showModalBottomSheet<bool>(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, ss) {
              return Observer(
                builder: (context) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.92,
                    ),
                    child: Container(
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
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                    top: 10,
                                    bottom: 20,
                                  ),
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
                              ],
                            ),
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                content,
                                Positioned(
                                  top: -15,
                                  right: 5,
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      color: CustomColors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      );
    }
  } catch (e, s) {
    printException('CustomModalBottomSheet', e, s);
  }
}
