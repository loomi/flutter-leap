import 'package:flutter/material.dart';

import '../utils/custom_colors.dart';
import '../utils/fonts.dart';

showCustomSnackBar(
  BuildContext context, {
  Widget? content,
  String? textContent,
  TextStyle? textStyle,
  Color? defaultTextColor,
  Color? backgroundColor,
  EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
  EdgeInsets margin = const EdgeInsets.all(12),
  bool? showCloseIcon,
  Duration duration = const Duration(seconds: 3),
  Animation<double>? animation,
  double? borderRadius,
  void Function()? onVisible,
  DismissDirection dismissDirection = DismissDirection.down,
  Clip clipBehavior = Clip.hardEdge,
}) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor ?? CustomColors.primary,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              borderRadius ?? 8,
            ),
          ),
        ),
        margin: margin,
        content: content ??
            Text(
              textContent ?? "",
              style: textStyle ??
                  Fonts.mobileCaption1.copyWith(
                    color: defaultTextColor ?? CustomColors.black,
                  ),
            ),
        behavior: SnackBarBehavior.floating,
        showCloseIcon: showCloseIcon,
        duration: duration,
        animation: animation,
        onVisible: onVisible,
        dismissDirection: dismissDirection,
        clipBehavior: clipBehavior,
      ),
    );
