import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:loomi_ui_flutter/widgets/custom_button.dart';

import 'package:flutter_leap_v2/shared/utils/theme/app_colors_theme.dart';

import '../../components/custom_modal_bottom_sheet.dart';
import '../fonts.dart';

void showConfirmationDialogHelper({
  required BuildContext context,
  String? confirmButtonText,
  required String title,
  required String body,
}) {
  if (kIsWeb) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),
            child: Center(
              child: Text(
                title,
                style: Fonts.mobileBody1,
              ),
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),
            child: Text(
              body,
              textAlign: TextAlign.center,
              style: Fonts.mobileBody2.copyWith(
                color: appColors.black.withOpacity(0.8),
              ),
            ),
          ),
          actions: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: confirmButtonText ?? "Ok",
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        expanded: true,
                        backgroundColor: appColors.primary,
                        buttonTextStyle:
                            Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  color: appColors.white,
                                ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  } else {
    showCustomModalBottomSheet(
      context,
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),
            child: Center(
              child: Text(
                title,
                style: Fonts.mobileBody1,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),
            child: Text(
              body,
              textAlign: TextAlign.center,
              style: Fonts.mobileBody2.copyWith(
                color: appColors.black.withOpacity(0.8),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: confirmButtonText ?? "Ok",
                    backgroundColor: appColors.primary,
                    buttonTextStyle:
                        Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: appColors.white,
                            ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    expanded: true,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
