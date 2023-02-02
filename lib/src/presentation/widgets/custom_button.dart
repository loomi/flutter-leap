import 'package:flutter/material.dart';
import 'package:loomi_flutter_boilerplate/src/utils/custom_colors.dart';
import 'package:loomi_flutter_boilerplate/src/utils/fonts.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.backgroundColor,
    this.margin,
    this.padding,
    this.borderColor,
    this.borderThickness,
    this.expanded = false,
    this.borderRadius,
    this.textStyle,
    this.textColor,
    this.leading,
    this.trailing,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  final Color? backgroundColor;
  final String text;
  final TextStyle? textStyle;
  final Color? textColor;
  final Widget? leading;
  final Widget? trailing;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color? borderColor;
  final double? borderThickness;
  final bool expanded;
  final double? borderRadius;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? CustomColors.black,
          borderRadius: BorderRadius.circular(borderRadius ?? 32),
          border: Border.all(
            color: borderColor ?? Colors.transparent,
            width: borderThickness ?? 0.0,
          ),
        ),
        padding: padding ?? const EdgeInsets.symmetric(vertical: 25),
        margin: margin ?? EdgeInsets.zero,
        child: Row(
          mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leading != null) leading!,
            Flexible(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: textStyle ??
                    Fonts.headline5.copyWith(
                      color: textColor ?? CustomColors.white,
                    ),
              ),
            ),
            if (trailing != null) trailing!
          ],
        ),
      ),
    );
  }
}
