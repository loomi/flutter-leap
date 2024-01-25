import 'package:flutter/widgets.dart';

import 'package:scaled_app/scaled_app.dart';

import '../utils/screen_utils.dart';

class ScaledAppWrapper extends StatelessWidget {
  final Widget child;
  const ScaledAppWrapper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtils.setScale();

    return MediaQuery(
      data: MediaQuery.of(context).scale(),
      child: child,
    );
  }
}
