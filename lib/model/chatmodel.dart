import 'package:flutter/material.dart';

class ChatModel with ChangeNotifier {
  String value;
  String? image;
  bool isCurrentUser;
  ChatModel({required this.image,required this.value, required this.isCurrentUser});
}
