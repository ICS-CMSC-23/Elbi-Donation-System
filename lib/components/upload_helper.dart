import 'package:image_picker/image_picker.dart';
import 'dart:io';

Future<String?> pickImage() async {
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  return pickedFile?.path;
}

Future<List<File>> pickMultipleImages() async {
  final List<XFile>? pickedFiles = await ImagePicker().pickMultiImage();
  if (pickedFiles != null && pickedFiles.isNotEmpty) {
    return pickedFiles.map((file) => File(file.path)).toList();
  }
  return [];
}

void removeImage(List<File> images, int index) {
  images.removeAt(index);
}

void remove(Function(String?) setImagePath) {
  setImagePath(null);
}
