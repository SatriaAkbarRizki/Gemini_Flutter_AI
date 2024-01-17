import 'package:aispeak/service/savetheme.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  SaveTheme saveTheme = SaveTheme();
  bool themeValue = false;

  ThemeProvider() {
    getThemeMode();
  }

  void changeTheme(bool value) async {
    themeValue = !value;
    Future.delayed(const Duration(milliseconds: 200))
        .whenComplete(() async => await saveTheme.saveThemeMode(themeValue));
    notifyListeners();
  }

  Future<bool> getThemeMode() async {
    late bool valueMode;
    await saveTheme.getThemeMode().then((value) {
      if (value == null) {
        valueMode = false;
      } else {
        valueMode = value;
      }
    });

    if (valueMode == true) {
      themeValue = true;
    } else {
      themeValue = false;
    }

    notifyListeners();
    return themeValue;
  }
}
