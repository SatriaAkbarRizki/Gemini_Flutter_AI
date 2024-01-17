import 'dart:convert';
import 'dart:io';
import 'package:aispeak/service/pickimage.dart';
import 'package:flutter/material.dart';

class PickImageProvider with ChangeNotifier {
  File? image;

  PickImage pickImage = PickImage();

  Future<String> gettingImage() async {
    await pickImage.pickerImage().then((value) => image = value);
    notifyListeners();
    return image!.path;
  }

  File imageConvert(File image) {
    List<int> value = image!.readAsBytesSync();
    String encodeImage = base64Encode(value);
    final decodeImage = base64Decode(encodeImage);
    var file = File(image!.path);
    file.writeAsBytesSync(decodeImage);
    return file;
  }
}
