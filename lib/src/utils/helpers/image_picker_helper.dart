import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

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
