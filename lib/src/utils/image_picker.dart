import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerUtils {
  static Future<File?> pickMedia({
    required ImageSource source,
  }) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile == null) return null;
    return File(pickedFile.path);
  }
}
