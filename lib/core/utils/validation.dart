import 'package:fiver/core/extensions/ext_localization.dart';
import 'package:fiver/core/utils/navigation_service.dart';
import 'package:flutter/material.dart';

class Validator {
  static final GlobalKey<ScaffoldMessengerState> _appKey =
      NavigationService.scaffoldKey;
  static BuildContext get _currentContext => _appKey.currentContext!;
  static bool isValidPhoneNumber(String? value) =>
      RegExp(r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{5}$)')
          .hasMatch(value ?? '');

  static bool isValidEmail(String? email) => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email ?? '');

  static String nameValidation(String value) {
    if (value.isEmpty) {
      return _currentContext.loc.field_required(_currentContext.loc.name);
    }
    if (value.length < 2) {
      return _currentContext.loc.format_name_notice;
    }
    return "";
  }

  static String emailValidateCtr(String value) {
    final result = Validator.isValidEmail(value);
    if (!result) {
      return _currentContext.loc.format_email_notice;
    }
    return "";
  }

  static String passwordValidateCtr(String value) {
    if (value.isEmpty) {
      return _currentContext.loc.field_required(_currentContext.loc.password);
    }
    if (value.length < 6) {
      return _currentContext.loc.format_password_notice;
    }
    return "";
  }
}
