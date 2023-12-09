import 'package:fiver/core/enum.dart';
import 'package:fiver/core/di/locator_service.dart';
import 'package:fiver/domain/repositories/system_repository.dart';
import 'package:fiver/core/res/colors.dart';
import 'package:fiver/core/res/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final appThemeData = {
  AppTheme.white: ThemeData(
    primaryColor: colorPrimary,
    primaryColorDark: colorWhite,
    scaffoldBackgroundColor: colorPrimary,
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
    primaryColorDark: colorPrimaryBlack,
    scaffoldBackgroundColor: colorPrimaryBlack,
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

  void init() async {
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

  Color get textColorGray => getColorTheme(color9B9B9B, color9B9B9B);

  Color get textColorBlackWhiteInput => getColorTheme(color2D2D2D, colorF5F5F5);

  // Theme colors

  Color get themeColorWhiteBlack => getColorTheme(colorWhite, colorBlack);

  Color get themeColorBlack => getColorTheme(colorBlack, colorWhite);

  Color get themeColorGreen => getColorTheme(color2AA952, color2AA952);

  Color get themeColorBlackWhite => getColorTheme(colorBlack, colorWhite);

  Color get themeColorPrimary => getColorTheme(colorPrimary, colorPrimaryBlack);

  Color get themeColorRed => getColorTheme(colorEF3651, colorEF3651);

  Color get themeColorDADADA => getColorTheme(colorDADADA, colorDADADA);

  Color get themeColorGrey => getColorTheme(color9B9B9B, colorABB4BD);

  Color get themeColorAAAAAAA =>
      getColorTheme(colorAAAAAA, colorWhite.withOpacity(0.7));

  // Background colors

  Color get bgColorWhiteBlack => getColorTheme(colorWhite, colorBlack);

  Color get bgColorPrimary => getColorTheme(colorPrimary, colorPrimary);
}
