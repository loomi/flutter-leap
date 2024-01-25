import 'package:flutter/material.dart';

import 'package:loomi_ui_flutter/loomi_ui.dart';

// ignore: must_be_immutable
class CustomBottomNavigationBar extends StatefulWidget {
  final Function(int) onClick;
  final Color? backgroundColor;
  int index;
  CustomBottomNavigationBar({
    Key? key,
    required this.onClick,
    required this.index,
    this.backgroundColor,
  }) : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor ?? Colors.white,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: BottomNavigationBarIconButton(
                    icon: GetIcon(
                      CustomIcons.home,
                      width: 22,
                      heigth: 22,
                    ),
                    selectedIcon: GetIcon(
                      CustomIcons.homeFilled,
                      width: 23,
                      heigth: 23,
                    ),
                    text: "",
                    onTap: () async {
                      widget.onClick(0);
                    },
                    selected: widget.index == 0,
                  ),
                ),
                Flexible(
                  child: BottomNavigationBarIconButton(
                    icon: GetIcon(
                      CustomIcons.home,
                      width: 22,
                      heigth: 22,
                    ),
                    selectedIcon: GetIcon(
                      CustomIcons.homeFilled,
                      width: 23,
                      heigth: 23,
                    ),
                    text: "",
                    onTap: () async {
                      widget.onClick(1);
                    },
                    selected: widget.index == 1,
                  ),
                ),
                Flexible(
                  child: BottomNavigationBarIconButton(
                    icon: GetIcon(
                      CustomIcons.home,
                      width: 22,
                      heigth: 22,
                    ),
                    selectedIcon: GetIcon(
                      CustomIcons.homeFilled,
                      width: 23,
                      heigth: 23,
                    ),
                    text: "",
                    onTap: () async {
                      widget.onClick(2);
                    },
                    selected: widget.index == 2,
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

class BottomNavigationBarIconButton extends StatelessWidget {
  final Widget icon;
  final Widget selectedIcon;
  final String text;
  final Function() onTap;
  final bool selected;

  const BottomNavigationBarIconButton({
    required this.onTap,
    required this.text,
    required this.icon,
    required this.selectedIcon,
    this.selected = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                selected ? selectedIcon : icon,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
