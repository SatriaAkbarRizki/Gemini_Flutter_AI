import 'dart:async';
import 'dart:io';
import 'package:aispeak/provider/pickimage_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import '../model/chatmodel.dart';

class ResultProvider with ChangeNotifier {
  final _pickImageProvider = PickImageProvider();
  final gemini = Gemini.instance;
  final List<ChatModel> _listChat = List.generate(
      0, (index) => ChatModel(value: '', image: null, isCurrentUser: false));

  bool isClose = false;
  bool isScroll = false;
  List<ChatModel> get listChat => _listChat;

  File? _imageResult;
  late File imageResult;
  late String message;

  Stream<String>? resultStream;
  StreamController<String> valueStream = StreamController<String>();

  Stream<String> fetchData() {
    if (_imageResult == null) {
      gemini
          .streamGenerateContent(message,
              generationConfig: GenerationConfig(
                maxOutputTokens: 1000,
                temperature: 0.5,
              ))
          .listen(
        (value) {
          valueStream.add(value.output!);

          _listChat.add(ChatModel(
              value: value.output.toString(),
              image: null,
              isCurrentUser: false));
        },
        onError: (e) {
          valueStream.add(e.toString());
          print('Error Message: ${e.toString()}');
          _listChat.add(ChatModel(
              value: "Sorry me can't answer you, try again...",
              image: null,
              isCurrentUser: false));
          isClose = false;
        },
      );
    } else {
      gemini
          .streamGenerateContent(message,
              images: [imageResult.readAsBytesSync()],
              generationConfig: GenerationConfig(
                maxOutputTokens: 1000,
                temperature: 0.5,
              ))
          .listen(
        (value) {
          valueStream.add(value.output!);

          _listChat.add(ChatModel(
              value: value.output.toString(),
              image: null,
              isCurrentUser: false));
        },
        onError: (e) {
          valueStream.add(e.toString());
          print('Error Message: ${e.toString()}');
          _listChat.add(ChatModel(
              value: "Sorry me can't answer you, try again...",
              image: null,
              isCurrentUser: false));
          isClose = false;
        },
      );
      _listChat
          .removeWhere((element) => element.image == _imageResult.toString());
    }
    resultStream = valueStream.stream;
    notifyListeners();
    return resultStream!;
  }

  void newChat(String value, String? image) {
    if (image != null) {
      _imageResult = _pickImageProvider.imageConvert(File(image));
      imageResult = _imageResult!;
    }
    message = value;
    fetchData();
    _listChat.add(ChatModel(value: value, image: image, isCurrentUser: true));
    notifyListeners();
  }

  void scrollDownList() {
    if (isScroll == false) {
      isScroll = true;
    } else {
      isScroll = false;
    }

    notifyListeners();
  }

  void closeStream() {
    valueStream.close();
    notifyListeners();
  }
}
