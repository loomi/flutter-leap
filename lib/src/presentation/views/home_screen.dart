import 'package:flutter/material.dart';

import 'package:flutter_leap/src/utils/custom_colors.dart';
import 'package:flutter_leap/src/utils/helpers/loomi_date_time.dart';
import 'package:loomi_ui_flutter/loomi_ui.dart';

import '../widgets/bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    Container(
      color: Colors.red.withOpacity(0.3),
    ),
    Container(
      color: Colors.green.withOpacity(0.3),
    ),
    Container(
      color: Colors.blue.withOpacity(0.3),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    DateTime.now().formatLastSeenDate;
    return Scaffold(
      backgroundColor: CustomColors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(DateTime.now().formatLastSeenDate),
            Text(DateTime.now().add(Duration(minutes: -10)).formatLastSeenDate),
            Text(DateTime.now().add(Duration(hours: -1)).formatLastSeenDate),
            Text(DateTime.now().add(Duration(days: -1)).formatLastSeenDate),
            Text(DateTime.now().add(Duration(days: 2)).formatLastSeenDate),
            const SizedBox(
              height: 24,
            ),
            Text(DateTime.now().formatedDateString()),
            Text(DateTime.now().formatedDateString(format: 'dd/MMM/yyyy')),
            Text(DateTime.now().formatedDateString(format: 'dd/MMMM/yyyy')),
            Text(DateTime.now().formatedDateString(format: 'dd MMMM yyyy')),
            Text(DateTime.now().formatedDateString(format: 'dd MMMM yyyy')),
          ],
        ),
      ),
    );
  }
}
