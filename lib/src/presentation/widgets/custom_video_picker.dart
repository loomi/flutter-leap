import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPicker extends StatefulWidget {
  const CustomVideoPicker({
    Key? key,
    this.label,
    this.labelStyle,
    required this.onAdd,
    this.onRemove,
    this.videoHeight,
    this.maxDuration,
    this.iconColor,
    this.removeWidget,
  }) : super(key: key);

  final String? label;
  final TextStyle? labelStyle;
  final Function(File file) onAdd;
  final Function(File file)? onRemove;
  final double? videoHeight;
  final Duration? maxDuration;
  final Color? iconColor;
  final Widget? removeWidget;

  @override
  State<CustomVideoPicker> createState() => _CustomVideoPickerState();
}

class _CustomVideoPickerState extends State<CustomVideoPicker> {
  final picker = ImagePicker();

  List<File> files = [];

  List<VideoPlayerController> controllers = [];

  void chooseVideo(ImageSource source, BuildContext context) async {
    final pickedFile = await picker.pickVideo(
      source: source,
      preferredCameraDevice: CameraDevice.front,
      maxDuration: widget.maxDuration,
    );
    XFile? xfilePick = pickedFile;

    if (xfilePick != null) {
      var file = File(pickedFile!.path);
      files.add(file);
      VideoPlayerController controller = VideoPlayerController.file(files.last)
        ..initialize().then((_) {
          setState(() {});
        });
      controllers.add(controller);
      widget.onAdd(file);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nenhum vídeo não foi escolhido'),
        ),
      );
    }
  }

  void onRemoveVideo(int index, BuildContext context) {
    if (widget.onRemove != null) {
      var file = files[index];
      widget.onRemove!(file);
    }
    setState(() {
      controllers.remove(controllers[index]);
      files.removeAt(index);
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => showChooseCameraOrFilesModal(),
                  child: Container(
                      width: 120,
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
                            color: widget.iconColor ??
                                Theme.of(context).primaryColor,
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            widget.label ?? "Escolha um vídeo",
                            style: widget.labelStyle ??
                                TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 12,
                                ),
                          ),
                        ],
                      )),
                ),
                ...List.generate(
                  controllers.length,
                  (index) => Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (controllers[index].value.isInitialized)
                        Container(
                          margin: const EdgeInsets.all(8),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return ShowVideoDialog(
                                      controllers[index],
                                      onRemove: widget.onRemove != null
                                          ? () {
                                              onRemoveVideo(index, context);
                                            }
                                          : null,
                                      removeWidget: widget.removeWidget,
                                    );
                                  });
                            },
                            child: SizedBox(
                              height: widget.videoHeight ?? 50,
                              width: widget.videoHeight ?? 50,
                              child: VideoPlayer(
                                controllers[index],
                              ),
                            ),
                          ),
                        )
                      else
                        Container(),
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  showChooseCameraOrFilesModal() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          backgroundColor: Colors.transparent,
          content: IntrinsicHeight(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final status = await Permission.camera.request();
                        if (status.isGranted) {
                          chooseVideo(ImageSource.camera, context);
                          Navigator.pop(context);
                        } else {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Permissão de acesso não concedida'),
                            ),
                          );
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Gravar vídeo",
                            style: widget.labelStyle ??
                                const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                          ),
                          Icon(
                            Icons.video_call_sharp,
                            color: widget.iconColor ?? Colors.black,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        final status = await Permission.storage.request();
                        if (status.isGranted) {
                          chooseVideo(ImageSource.gallery, context);
                          Navigator.pop(context);
                        } else {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Permissão de acesso não concedida'),
                            ),
                          );
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Buscar vídeo",
                            style: widget.labelStyle ??
                                const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                          ),
                          Icon(
                            Icons.upload_file_outlined,
                            color: widget.iconColor ?? Colors.black,
                          ),
                        ],
                      ),
                    )
                  ]),
            ),
          ),
        );
      },
    );
  }
}

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
      backgroundColor: Colors.transparent,
      content: IntrinsicHeight(
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      widget.controller.pause();
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.highlight_remove_sharp,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isPlaying = !isPlaying;
                      if (isPlaying) {
                        widget.controller.play();
                      } else {
                        widget.controller.pause();
                      }
                    });
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AspectRatio(
                        aspectRatio: widget.controller.value.aspectRatio,
                        child: VideoPlayer(
                          widget.controller,
                        ),
                      ),
                      Visibility(
                        visible: !isPlaying,
                        child: const Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.play_arrow,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                if (widget.onRemove != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: widget.onRemove,
                      child: widget.removeWidget ??
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              Text(
                                "Excluir vídeo",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                    ),
                  ),
              ]),
        ),
      ),
    );
  }
}
