import 'dart:io';

import 'package:image_picker/image_picker.dart';

class PickImage {
  final ImagePicker picker = ImagePicker();

  Future<File?> pickerImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    return File(image.path);
  }
}
