import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.backgroundColor,
    this.margin,
    this.padding,
    required this.onTap,
    this.borderColor,
    this.borderThickness,
    required this.expanded,
    this.borderRadius,
    required this.text,
    this.textStyle,
    required this.textColor,
    this.leading,
    this.trailing,
  }) : super(key: key);

  final Color backgroundColor;
  final String text;
  final TextStyle? textStyle;
  final Color textColor;
  final Widget? leading;
  final Widget? trailing;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Function() onTap;
  final Color? borderColor;
  final double? borderThickness;
  final bool expanded;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius ?? 5),
          border: Border.all(
              color: borderColor ?? Colors.transparent,
              width: borderThickness ?? 0.0),
        ),
        padding: padding ?? const EdgeInsets.all(10),
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
                style: textStyle ?? TextStyle(color: textColor),
              ),
            ),
            if (trailing != null) trailing!
          ],
        ),
      ),
    );
  }
}
