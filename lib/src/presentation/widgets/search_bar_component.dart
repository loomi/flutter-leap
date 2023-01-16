import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/custom_colors.dart';
import '../../utils/fonts.dart';
import '../../utils/helpers/assets_helper.dart';

class SearchBarComponent extends StatefulWidget {
  final String hintText;
  final Function(String) onChanged;
  final Function()? onCloseAction;
  final Function(String)? onFieldSubmitted;
  final bool enabled;
  final double? verticalPadding;
  final TextEditingController? textEditingController;
  const SearchBarComponent({
    required this.hintText,
    required this.onChanged,
    this.onCloseAction,
    this.textEditingController,
    this.onFieldSubmitted,
    this.enabled = true,
    this.verticalPadding = 10.0,
    Key? key,
  }) : super(key: key);

  @override
  State<SearchBarComponent> createState() => _SearchBarComponentState();
}

class _SearchBarComponentState extends State<SearchBarComponent> {
  Timer? _debounce;

  _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 550),
      () {
        widget.onChanged(value);
      },
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 14,
        vertical: widget.verticalPadding!,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              getAssetVectorUrl(
                "search.svg",
              ),
              width: 20,
            ),
          ),
          Flexible(
            child: TextFormField(
              onChanged: (value) {
                _onSearchChanged(value);
              },
              onFieldSubmitted: (value) {
                _onSearchChanged(value);
              },
              style: Fonts.headline5.copyWith(
                fontWeight: FontWeight.w500,
                color: CustomColors.black,
              ),
              controller: widget.textEditingController,
              enabled: widget.enabled,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(top: 14, left: 6),
                hintText: widget.hintText,
                hintStyle: Fonts.headline5.copyWith(
                  fontWeight: FontWeight.normal,
                  color: CustomColors.black.withOpacity(.4),
                ),
                suffixIcon: Visibility(
                  visible: widget.textEditingController != null &&
                      widget.textEditingController!.text.isNotEmpty,
                  child: GestureDetector(
                    child: Icon(
                      Icons.close,
                      color: CustomColors.black.withOpacity(0.3),
                    ),
                    onTap: widget.onCloseAction,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: CustomColors.grey,
      ),
    );
  }
}
