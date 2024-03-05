import 'package:flutter/material.dart';

import '../extensions/ext_localization.dart';
import 'navigation_service.dart';

class ValidatorUtil {
  static final GlobalKey<ScaffoldMessengerState> _appKey =
      NavigationService.scaffoldKey;
  static BuildContext get _currentContext => _appKey.currentContext!;

  static bool isValidPhoneNumber(String? value) =>
      RegExp(r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{5}$)')
          .hasMatch(value ?? '');

  static bool isValidEmail(String? email) => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email ?? '');

  static bool isValidDateOfBirth(String? dateOfBirth) =>
      RegExp(r'^(\d{2})/(\d{2})/(\d{4})$').hasMatch(
        dateOfBirth ?? '',
      );

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
    final result = ValidatorUtil.isValidEmail(value);
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

  static String confirmPasswordValidateCtr(
    String newPassword,
    String confirmPassword,
  ) {
    if (confirmPassword != newPassword) {
      return _currentContext.loc.confirm_password_validation;
    }
    return "";
  }

  static String dateOfBirthValidation(String value) {
    if (value.isEmpty) {
      return _currentContext.loc
          .field_required(_currentContext.loc.date_of_birth);
    }

    if (!isValidDateOfBirth(value)) {
      return _currentContext.loc.format_date_of_birth_notice;
    }

    final List<String> splitValue = value.split('/');

    final year = int.parse(splitValue[2]);
    final month = int.parse(splitValue[1]);
    final day = int.parse(splitValue[0]);

    if (year >= DateTime.now().year) {
      return _currentContext.loc.format_date_of_birth_notice;
    }

    if (day == 0 || day > 31) {
      return _currentContext.loc.format_date_of_birth_notice;
    }

    if (month == 0 || month > 12) {
      return _currentContext.loc.format_date_of_birth_notice;
    }

    if (month == 2 && day > 29) {
      return _currentContext.loc.format_date_of_birth_notice;
    }

    if ((month == 4 || month == 6 || month == 9 || month == 11) && day > 30) {
      return _currentContext.loc.format_date_of_birth_notice;
    }

    return "";
  }
}
