// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

import '../../model/user_info_model.dart';

class Preferences {
  static const THEME = "theme";
  static const LANGUAGE = "language";
  static const ACCESS_TOKEN = "access_token";
  static const PRICE_RANGE = "price_range";
  static const COLORS = "colors";
  static const DEVICE_TOKEN = "device_token";
  static const USER = "user";

  late final SharedPreferences prefs;

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
      [
        prefs.remove(THEME),
        prefs.remove(LANGUAGE),
        prefs.remove(ACCESS_TOKEN),
        prefs.remove(USER),
      ],
    );
  }

  Future<void> savePriceRange(List<double> priceRange) async {
    final toStringList =
        List<String>.from(priceRange.map((e) => e.toString()).toList());
    await prefs.setStringList(PRICE_RANGE, toStringList);
  }

  List<double> getPriceRange() {
    final values = prefs.getStringList(PRICE_RANGE) ?? [];

    final toDoubleList =
        List<double>.from(values.map((e) => double.parse(e)).toList());

    return toDoubleList;
  }

  Future<void> saveColors(List<Color> colors) async {
    final toStringList =
        List<String>.from(colors.map((e) => e.value.toString()).toList());
    await prefs.setStringList(COLORS, toStringList);
  }

  List<Color> getColors() {
    final values = prefs.getStringList(COLORS) ?? [];

    final toColorList =
        List<Color>.from(values.map((e) => Color(int.parse(e))).toList());

    return toColorList;
  }

  Future<void> clear() async {
    await prefs.clear();
  }

  Future<void> setDeviceToken(String deviceToken) async {
    await prefs.setString(DEVICE_TOKEN, deviceToken);
  }

  String? getDeviceToken() {
    return prefs.getString(DEVICE_TOKEN);
  }

  Future<void> saveUser(UserInfoModel user) async {
    await prefs.setString(USER, jsonEncode(user.toJson()));
  }

  UserInfoModel? getUser() {
    final value = prefs.getString(USER);

    if (value == null) return null;

    return UserInfoModel.fromJson(json.decode(value));
  }
}
