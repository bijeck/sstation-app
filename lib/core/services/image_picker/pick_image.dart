import 'dart:io';

import 'package:image_picker/image_picker.dart';

class PickImage {
  static Future<File?> pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(
      source: source,
      imageQuality: 50,
    );

    if (pickedImage == null) {
      return null;
    }

    final imageFile = File(pickedImage.path);
    return imageFile;
  }
}
