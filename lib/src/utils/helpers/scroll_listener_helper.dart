import 'package:flutter/widgets.dart';

void listenToScrollController({
  required ScrollController scrollController,
  required Function() onLoad,
}) {
  scrollController.addListener(() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      await onLoad();
      scrollController.animateTo(
        scrollController.position.pixels + 150,
        curve: Curves.linear,
        duration: const Duration(milliseconds: 300),
      );
    }
  });
}
