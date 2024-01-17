import 'package:shared_preferences/shared_preferences.dart';

class SaveTheme{
  final Future<SharedPreferences> _prefs =  SharedPreferences.getInstance();

  Future<void> saveThemeMode (bool value) async{
    final prefs = await _prefs;
    await prefs.setBool('mode', value);
  }

  Future getThemeMode() async{
    final prefs = await _prefs;
    return prefs.getBool('mode');
  }

}