import 'package:flutter/material.dart';

import 'package:connectivity_wrapper/connectivity_wrapper.dart';

import '../utils/custom_colors.dart';
import '../utils/fonts.dart';

class OfflineWrapperComponent extends StatefulWidget {
  final Widget child;
  const OfflineWrapperComponent({
    super.key,
    required this.child,
  });

  @override
  State<OfflineWrapperComponent> createState() =>
      _OfflineWrapperComponentState();
}

class _OfflineWrapperComponentState extends State<OfflineWrapperComponent> {
  @override
  Widget build(BuildContext context) {
    return ConnectivityWidgetWrapper(
      child: widget.child,
      disableInteraction: false,
      color: CustomColors.primary,
      alignment: Alignment.bottomCenter,
      offlineWidget: IgnorePointer(
        ignoring: true,
        child: SizedBox(
          height: 75,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Container(
                decoration: BoxDecoration(
                  color: CustomColors.black.withOpacity(0.75),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: CustomColors.white,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Sem conexão com a internet",
                        style: Fonts.mobileBody1.copyWith(
                          color: CustomColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
