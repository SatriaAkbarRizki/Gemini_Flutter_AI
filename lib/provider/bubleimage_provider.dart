import 'package:flutter/material.dart';

class BubbleProvider with ChangeNotifier{
  bool inClose = true;

  void changeBool(){
    inClose = !inClose;
    notifyListeners();
  }
}