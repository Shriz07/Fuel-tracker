import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePreference {
  static const key = 'THEMESTATUS';

  void setDarkTheme(bool value) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<bool> getTheme() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }
}
