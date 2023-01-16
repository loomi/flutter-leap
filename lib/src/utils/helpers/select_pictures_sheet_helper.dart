import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:loomi_flutter_boilerplate/src/utils/custom_colors.dart';

void openSelectPictureSheet(
  BuildContext context, {
  required Function() getImageCamera,
  required Function() getImageGallery,
}) async {
  try {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Wrap(
                children: <Widget>[
                  GestureDetector(
                    onTap: getImageGallery,
                    child: Container(
                      width: double.infinity,
                      height: 55,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: CustomColors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                      ),
                      child: Text(
                        "Escolher na biblioteca",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: CustomColors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: getImageCamera,
                    child: Container(
                      width: double.infinity,
                      height: 55,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: CustomColors.white,
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                      ),
                      child: Text(
                        "Tirar foto",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: CustomColors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 30),
                      width: double.infinity,
                      height: 55,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: CustomColors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            15,
                          ),
                        ),
                      ),
                      child: Text(
                        "Cancelar",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: CustomColors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  } catch (e) {
    log(e.toString());
  }
}
