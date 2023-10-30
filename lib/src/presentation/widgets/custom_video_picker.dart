import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

import 'package:flutter_leap/src/utils/custom_colors.dart';

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
                onTap: () => showChooseCameraOrFilesModal(context),
                child: Container(
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
                        color:
                            widget.iconColor ?? Theme.of(context).primaryColor,
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
                  ),
                ),
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
                              },
                            );
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
            ],
          ),
        ),
      ),
    );
  }

  void showChooseCameraOrFilesModal(BuildContext context) async {
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
                          "Gravar Vídeo",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: CustomColors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
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
                              content: Text(
                                'Permissão de acesso não concedida',
                              ),
                            ),
                          );
                        }
                      },
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
                          "Buscar Vídeo",
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
