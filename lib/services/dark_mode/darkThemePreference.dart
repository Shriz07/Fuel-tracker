import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePreference {
  static const THEME_STATUS = 'THEMESTATUS';

  setDarkTheme(bool value) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setBool(THEME_STATUS, value);
  }

  Future<bool> getTheme() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getBool(THEME_STATUS) ?? false;
  }
}
