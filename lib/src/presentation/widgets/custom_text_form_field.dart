import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loomi_flutter_boilerplate/src/utils/custom_colors.dart';

class CustomTextFormField extends StatefulWidget {
  final String? hintText;
  final String? errorText;
  final String? labelText;
  final String? initialValue;
  final int? maxLines;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? backgroundColor;
  final TextStyle? labelStyle;
  final TextStyle? errorStyle;
  final TextStyle? hintTextStyle;
  final TextStyle? textStyle;
  final bool enabled;
  final bool readOnly;
  final bool isPassword;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final Function()? onTap;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatterList;
  final AutovalidateMode? autovalidateMode;
  final TextEditingController? textEditingController;
  final TextCapitalization capitalization;
  final TextInputAction textInputAction;
  final Color? iconColor;
  final double? borderRadius;
  final EdgeInsets? padding;
  final InputBorder? border;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final Color? focusColor;
  final bool? filled;
  final Color? borderColor;
  final Color? errorBorderColor;
  final Color? focusedBorderColor;
  final Color? focusedErrorBorderColor;
  final bool inlineLabel;
  final double borderWidth;

  const CustomTextFormField({
    Key? key,
    this.hintText = "",
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.onTap,
    this.maxLines = 1,
    this.readOnly = false,
    this.onChanged,
    this.onFieldSubmitted,
    this.isPassword = false,
    this.labelText,
    this.initialValue,
    this.validator,
    this.inputFormatterList,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.enabled = true,
    this.errorText,
    this.backgroundColor,
    this.textEditingController,
    this.capitalization = TextCapitalization.none,
    this.textInputAction = TextInputAction.next,
    this.labelStyle,
    this.errorStyle,
    this.hintTextStyle,
    this.textStyle,
    this.iconColor,
    this.borderRadius,
    this.padding,
    this.border,
    this.focusColor,
    this.filled,
    this.errorBorder,
    this.focusedErrorBorder,
    this.prefixIcon,
    this.focusedBorder,
    this.borderColor,
    this.errorBorderColor,
    this.focusedBorderColor,
    this.focusedErrorBorderColor,
    this.inlineLabel = false,
    this.borderWidth = 2,
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool passwordIsVisible = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap != null
          ? () {
              widget.onTap!();
            }
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.labelText != null && !widget.inlineLabel)
            Padding(
              padding: const EdgeInsets.only(left: 12, bottom: 5),
              child: Text(
                widget.labelText!,
                style: widget.labelStyle,
              ),
            ),
          Container(
            padding: widget.padding ?? EdgeInsets.zero,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    onEditingComplete: () => Platform.isIOS
                        ? FocusScope.of(context).unfocus()
                        : FocusScope.of(context).nextFocus(),
                    onFieldSubmitted: widget.onFieldSubmitted,
                    controller: widget.textEditingController,
                    onChanged: widget.onChanged,
                    validator: widget.validator,
                    keyboardType: widget.keyboardType,
                    textCapitalization: widget.capitalization,
                    initialValue: widget.initialValue,
                    maxLines: widget.isPassword ? 1 : widget.maxLines,
                    obscureText: widget.isPassword && !passwordIsVisible,
                    inputFormatters: widget.inputFormatterList,
                    autovalidateMode: widget.autovalidateMode,
                    textInputAction: widget.textInputAction,
                    readOnly: widget.readOnly,
                    enabled: widget.enabled,
                    style: widget.isPassword && !passwordIsVisible
                        ? (widget.textStyle != null
                            ? widget.textStyle!.copyWith(
                                fontFamily: "Obscured",
                              )
                            : const TextStyle(
                                fontFamily: "Obscured",
                              ))
                        : widget.textStyle,
                    decoration: InputDecoration(
                      labelText: widget.inlineLabel ? widget.labelText : null,
                      labelStyle: widget.inlineLabel ? widget.labelStyle : null,
                      filled: widget.filled,
                      fillColor: widget.backgroundColor ?? CustomColors.grey,
                      hintText: widget.hintText,
                      errorText: widget.errorText,
                      errorBorder: widget.errorBorder ??
                          OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                widget.borderRadius ?? 12),
                            borderSide: BorderSide(
                              width: widget.borderWidth,
                              color: widget.errorBorderColor ?? Colors.red,
                            ),
                          ),
                      focusedBorder: widget.focusedBorder ??
                          OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                widget.borderRadius ?? 12),
                            borderSide: BorderSide(
                              width: widget.borderWidth,
                              color: widget.focusedBorderColor ?? Colors.blue,
                            ),
                          ),
                      focusedErrorBorder: widget.focusedErrorBorder ??
                          OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                widget.borderRadius ?? 12),
                            borderSide: BorderSide(
                              width: widget.borderWidth,
                              color:
                                  widget.focusedErrorBorderColor ?? Colors.red,
                            ),
                          ),
                      enabledBorder: widget.border ??
                          OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                widget.borderRadius ?? 12),
                            borderSide: BorderSide(
                              width: widget.borderWidth,
                              color: widget.borderColor ?? Colors.grey,
                            ),
                          ),
                      focusColor: widget.focusColor,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintStyle: widget.hintTextStyle,
                      errorStyle: widget.errorStyle,
                      prefixIcon: widget.prefixIcon,
                      suffixIcon: widget.isPassword
                          ? GestureDetector(
                              child: Icon(
                                passwordIsVisible
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: widget.iconColor,
                              ),
                              onTap: () {
                                setState(() {
                                  passwordIsVisible = !passwordIsVisible;
                                });
                              },
                            )
                          : widget.suffixIcon ?? const SizedBox.shrink(),
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
