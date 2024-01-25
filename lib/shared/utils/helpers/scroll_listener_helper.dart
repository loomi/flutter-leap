import 'package:flutter/widgets.dart';

void listenToScrollController({
  required ScrollController scrollController,
  required Function() onLoad,
}) {
  scrollController.addListener(() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      await onLoad();
    }
  });
}
