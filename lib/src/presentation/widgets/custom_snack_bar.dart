import 'package:flutter/material.dart';

showCustomSnackBar(
  BuildContext context, {
  required Widget content,
  Color backgroundColor = Colors.black,
  EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
  bool? showCloseIcon,
  Duration duration = const Duration(seconds: 3),
  Animation<double>? animation,
  void Function()? onVisible,
  DismissDirection dismissDirection = DismissDirection.down,
  Clip clipBehavior = Clip.hardEdge,
}) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        padding: padding,
        content: content,
        showCloseIcon: showCloseIcon,
        duration: duration,
        animation: animation,
        onVisible: onVisible,
        dismissDirection: dismissDirection,
        clipBehavior: clipBehavior,
      ),
    );
