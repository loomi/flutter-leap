import 'package:flutter/widgets.dart';
import 'package:flutter_leap/src/utils/screen_utils.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({super.key, required this.buildScreen});

  final Widget Function(BaseSize) buildScreen;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        BaseSize baseSize = ScreenUtils.getCurrentBaseSize(WidgetsBinding
                .instance.platformDispatcher.views.first.physicalSize /
            WidgetsBinding
                .instance.platformDispatcher.views.first.devicePixelRatio);

        return buildScreen.call(baseSize);
      },
    );
  }
}
