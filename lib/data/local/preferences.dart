// ignore_for_file: constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static const THEME = "theme";
  static late final SharedPreferences prefs;
  init() async {
    prefs = await SharedPreferences.getInstance();
  }

  void setTheme(int theme) async {
    await prefs.setInt(THEME, theme);
  }

  int getTheme() {
    return prefs.getInt(THEME) ?? 0;
  }
}
