import 'package:flutter/material.dart';

class TextProvider with ChangeNotifier {
  String _username = 'Not have username';
  String get username => _username;

  serUsername(String name) {
    _username = name;
    notifyListeners();
  }
}
