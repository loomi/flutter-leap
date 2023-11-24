import 'dart:io';

import 'package:flutter/material.dart';

import 'package:loomi_ui_flutter/widgets/custom_button.dart';

import 'package:flutter_leap/main.dart';
import 'package:flutter_leap/src/utils/custom_colors.dart';
import 'package:flutter_leap/src/utils/helpers/select_videos_sheet_helper.dart';
import 'package:flutter_leap/src/utils/localization/app_localizations.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../widgets/bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  List<File> files = [];
  onAdd(File file) {
    files.add(file);
  }

  onRemove(File file) {
    files.remove(file);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: IndexedStack(
                index: _currentIndex,
                children: [
                  Container(
                    color: Colors.red.withOpacity(0.3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => openSelectVideoSheet(context),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.video_call,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      "Escolha um vídeo",
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: Text(L10N.of(context)!.helloWorld),
                        ),
                        CustomButton(
                          text: "Trocar",
                          onTap: () async {
                            try {
                              int? test;
                              test! + 3;
                            } catch (exception, stackTrace) {
                              await Sentry.captureException(
                                exception,
                                stackTrace: stackTrace,
                              );
                            }
                            MyApp.setLocale(
                              context,
                              const Locale("es"),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  LocalizationOverriderBuilder(
                    languageCode: 'en',
                    builder: (context) {
                      return Container(
                        color: Colors.green.withOpacity(0.3),
                        child: Center(
                          child: Text(L10N.of(context)!.helloWorld),
                        ),
                      );
                    },
                  ),
                  LocalizationOverriderBuilder(
                    languageCode: 'es',
                    builder: (context) {
                      return Container(
                        color: Colors.blue.withOpacity(0.3),
                        child: Center(
                          child: Text(L10N.of(context)!.helloWorld),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomBottomNavigationBar(
                index: _currentIndex,
                onClick: (value) {
                  setState(() {
                    _currentIndex = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
