import 'package:fiven/res/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const fontFamily = "Metropolis";

const fontApp = TextStyle(
  fontFamily: fontFamily,
  fontWeight: FontWeight.normal,
);

TextStyle get text8 => fontApp.copyWith(fontSize: 8.sp);

TextStyle get text9 => fontApp.copyWith(fontSize: 9.sp);

TextStyle get text10 => fontApp.copyWith(fontSize: 10.sp);

TextStyle get text11 => fontApp.copyWith(fontSize: 11.sp);

TextStyle get text12 => fontApp.copyWith(fontSize: 12.sp);

TextStyle get text13 => fontApp.copyWith(fontSize: 13.sp);

TextStyle get text14 => fontApp.copyWith(fontSize: 14.sp);

TextStyle get text15 => fontApp.copyWith(fontSize: 15.sp);

TextStyle get text16 => fontApp.copyWith(fontSize: 16.sp);

TextStyle get text17 => fontApp.copyWith(fontSize: 17.sp);

TextStyle get text18 => fontApp.copyWith(fontSize: 18.sp);

TextStyle get text20 => fontApp.copyWith(fontSize: 20.sp);

TextStyle get text22 => fontApp.copyWith(fontSize: 22.sp);

TextStyle get text24 => fontApp.copyWith(fontSize: 24.sp);

TextStyle get text25 => fontApp.copyWith(fontSize: 25.sp);

TextStyle get text26 => fontApp.copyWith(fontSize: 26.sp);

TextStyle get text28 => fontApp.copyWith(fontSize: 28.sp);

TextStyle get text30 => fontApp.copyWith(fontSize: 30.sp);

TextStyle get text34 => fontApp.copyWith(fontSize: 34.sp);

TextStyle get text35 => fontApp.copyWith(fontSize: 35.sp);

TextStyle get text80 => fontApp.copyWith(fontSize: 80.sp);

extension TextStyleExtension on TextStyle {
  // Font Family
  TextStyle get normal => copyWith(fontWeight: FontWeight.normal);

  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);

  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);

  // Text Color

  TextStyle get textColorPrimary =>
      copyWith(color: getColor().textColorPrimary);
  TextStyle get textColorWhiteBlack =>
      copyWith(color: getColor().textColorWhiteBlack);
}
