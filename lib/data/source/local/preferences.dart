// ignore_for_file: constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static const THEME = "theme";
  static const LANGUAGE = "language";
  static const ACCESS_TOKEN = "access_token";

  static late final SharedPreferences prefs;
  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  void setTheme(int theme) async {
    await prefs.setInt(THEME, theme);
  }

  int getTheme() {
    return prefs.getInt(THEME) ?? 0;
  }

  setLanguage(String language) async {
    await prefs.setString(LANGUAGE, language);
  }

  Future<String?> getLanguage() async {
    return prefs.getString(LANGUAGE);
  }

  Future<void> setAccessToken(String accessToken) async {
    await prefs.setString(ACCESS_TOKEN, accessToken);
  }

  String getAccessToken() {
    return prefs.getString(ACCESS_TOKEN) ?? "";
  }

  Future<void> logout() async {
    await Future.wait(
      [prefs.remove(THEME), prefs.remove(LANGUAGE), prefs.remove(ACCESS_TOKEN)],
    );
  }
}
