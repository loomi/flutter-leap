import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

Future<File> getImageHelper({required ImageSource source}) async {
  final ImagePicker _picker = ImagePicker();
  XFile? image = await _picker.pickImage(
    source: source,
  );

  if (image != null) {
    return File(image.path);
  }

  return File("");
}

Future getFileHelper() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    File file = File(result.files.single.path!);
    return file;
  }
}
