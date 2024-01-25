import 'dart:io';

import 'package:flutter/material.dart';

import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loomi_ui_flutter/loomi_ui.dart';
import 'package:path_provider/path_provider.dart';

Future<File?> getImageHelper({required ImageSource source}) async {
  final ImagePicker _picker = ImagePicker();
  XFile? image = await _picker.pickImage(
    source: source,
  );

  if (image != null) {
    return File(image.path);
  }

  return null;
}

Future<File?> getFileHelper() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    File file = File(result.files.single.path!);
    return file;
  }

  return null;
}

Future<File?> getVideoHelper({
  required ImageSource source,
  Duration? maxDuration,
}) async {
  final ImagePicker _picker = ImagePicker();

  final pickedFile = await _picker.pickVideo(
    source: source,
    preferredCameraDevice: CameraDevice.front,
    maxDuration: maxDuration,
  );

  XFile? xfilePick = pickedFile;

  if (xfilePick != null) {
    var file = File(pickedFile!.path);
    return file;
  }

  return null;
}

Future pushToCameraScreen({
  required BuildContext context,
  String? popUntil,
  required Function(String) onFileAdded,
  Function()? helpIconFunction,
}) async {
  List<CameraDescription> cameras = await availableCameras();

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CameraScreen(
        cameras: cameras,
        helpIconFunction: helpIconFunction,
        onSave: (picture) {
          if (popUntil != null) {
            Navigator.popUntil(
              context,
              ModalRoute.withName(popUntil),
            );
          }
          onFileAdded(picture.path);
        },
      ),
    ),
  );
}

Future<File> compressAndGetFile({
  required File file,
  int minWidth = 1920,
  int minHeight = 1080,
}) async {
  String path = (await getTemporaryDirectory()).path;
  var result = File((await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        "$path/${DateTime.now().microsecondsSinceEpoch.toString()}.png",
        format: CompressFormat.png,
        minHeight: minHeight,
        minWidth: minWidth,
      ))
          ?.path ??
      "");
  if (result.path.isEmpty) {
    result = await compressAndGetFile(
      file: file,
      minHeight: minHeight,
      minWidth: minWidth,
    );
  }
  return result;
}
