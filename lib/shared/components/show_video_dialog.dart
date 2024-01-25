import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

class ShowVideoDialog extends StatefulWidget {
  final VideoPlayerController controller;
  final Function()? onRemove;
  final Widget? removeWidget;

  const ShowVideoDialog(this.controller,
      {super.key, this.onRemove, this.removeWidget});

  @override
  State<ShowVideoDialog> createState() => _ShowVideoDialogState();
}

class _ShowVideoDialogState extends State<ShowVideoDialog> {
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {
        isPlaying = widget.controller.value.isPlaying;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      insetPadding: const EdgeInsets.symmetric(
        vertical: 25,
        horizontal: 20,
      ),
      backgroundColor: Colors.transparent,
      content: IntrinsicHeight(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white,
          ),
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  setState(
                    () {
                      isPlaying = !isPlaying;
                      if (isPlaying) {
                        widget.controller.play();
                      } else {
                        widget.controller.pause();
                      }
                    },
                  );
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.85,
                        child: VideoPlayer(
                          widget.controller,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: !isPlaying,
                      child: const Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.play_arrow_sharp,
                          color: Colors.black,
                          size: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.onRemove != null)
                          GestureDetector(
                            onTap: widget.onRemove,
                            child: widget.removeWidget ??
                                const Icon(
                                  Icons.delete_outline_sharp,
                                  color: Colors.black,
                                  size: 30,
                                ),
                          ),
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            widget.controller.pause();
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.highlight_remove_sharp,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
