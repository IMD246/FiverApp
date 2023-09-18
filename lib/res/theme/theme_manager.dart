import 'package:fiven/constant/enum.dart';
import 'package:fiven/di/locator_service.dart';
import 'package:fiven/domain/repositories/system_repository.dart';
import 'package:fiven/res/colors.dart';
import 'package:fiven/res/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final appThemeData = {
  AppTheme.white: ThemeData(
    primaryColor: colorPrimary,
    primaryColorDark: colorWhite,
    scaffoldBackgroundColor: colorWhite,
    fontFamily: fontFamily,
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: colorWhite,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: colorWhite,
        statusBarIconBrightness: Brightness.light,
      ),
    ),
  ),
  AppTheme.dark: ThemeData(
    primaryColor: colorPrimary,
    primaryColorDark: colorBlack,
    scaffoldBackgroundColor: colorBlack,
    brightness: Brightness.dark,
    fontFamily: fontFamily,
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: colorWhite,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarColor: colorBlack,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
  )
};

class ThemeManager extends ChangeNotifier {
  ThemeData? _themeData;

  ThemeData get themeData {
    _themeData ??= appThemeData[AppTheme.white];
    return _themeData!;
  }

  init() async {
    _loadTheme();
  }

  void _loadTheme() async {
    final getTheme = locator<SystemRepository>().getTheme();
    currentAppTheme = AppTheme.values[getTheme];
    _themeData = appThemeData[currentAppTheme];
    notifyListeners();
  }

  void setTheme(AppTheme appTheme) async {
    currentAppTheme = appTheme;
    _themeData = appThemeData[appTheme];
    await locator<SystemRepository>()
        .setTheme(AppTheme.values.indexOf(appTheme));
    notifyListeners();
  }
}

AppTheme currentAppTheme = AppTheme.white;

ColorScheme getColor() => locator<ThemeManager>().themeData.colorScheme;

extension ColorSchemeExtension on ColorScheme {
  Color getColorTheme(Color colorThemeWhite, Color colorThemeBlack) {
    switch (currentAppTheme) {
      case AppTheme.dark:
        return colorThemeBlack;
      default:
        return colorThemeWhite;
    }
  }

  // Text colors

  Color get textColorWhiteBlack => getColorTheme(colorWhite, colorBlack);

  Color get textColorPrimary => getColorTheme(colorPrimary, colorPrimary);

  // Theme colors

  Color get themeColorWhiteBlack => getColorTheme(colorWhite, colorBlack);

  Color get themeColorPrimary => getColorTheme(colorPrimary, colorPrimary);

  // Background colors

  Color get bgColorWhiteBlack => getColorTheme(colorWhite, colorBlack);

  Color get bgColorPrimary => getColorTheme(colorPrimary, colorPrimary);
}
