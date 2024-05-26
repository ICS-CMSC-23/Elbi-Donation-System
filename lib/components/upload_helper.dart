import 'dart:convert';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'dart:io';

Future<String> convertXFileToBase64(XFile file) async {
  Uint8List? fileBytes = await file.readAsBytes();
  List<int> compressedBytes = zlib.encode(fileBytes);
  String base64Image = base64Encode(compressedBytes);
  return base64Image;
}

Future<List<String>> convertImagesToBase64(List<File> images) async {
  List<String> base64Images = [];

  for (File image in images) {
    List<int> imageBytes = await image.readAsBytes();
    List<int> compressedBytes = zlib.encode(imageBytes);
    String base64Image = base64Encode(compressedBytes);
    base64Images.add(base64Image);
  }

  return base64Images;
}

Future<String?> pickImage() async {
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    String base64String = await convertXFileToBase64(pickedFile);
    return (base64String);
  }
  return null;
}

Uint8List decodeBase64Image(String base64String) {
  // Decode base64 string to bytes
  Uint8List compressedBytes = base64Decode(base64String);

  // Decompress using zlib
  Uint8List decompressedBytes = zlib.decode(compressedBytes) as Uint8List;

  return decompressedBytes;
}

Uint8List decodeBase64ImageUncompressed(String base64String) {
  // Decode base64 string to bytes
  Uint8List compressedBytes = base64Decode(base64String);

  return compressedBytes;
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
