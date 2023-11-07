// ignore_for_file: use_build_context_synchronously
import 'package:fiver/core/base/base_model.dart';
import 'package:fiver/core/di/locator_service.dart';
import 'package:fiver/core/extensions/ext_localization.dart';
import 'package:fiver/core/provider/auth_provider.dart';
import 'package:fiver/domain/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../core/routes/app_router.dart';
import '../../../core/utils/validation.dart';

class LoginModel extends BaseModel {
  final TextEditingController emailCtr = TextEditingController();
  final TextEditingController passwordCtr = TextEditingController();
  final _repo = locator<UserRepository>();
  Future<bool> onBack() async {
    SystemNavigator.pop();
    return false;
  }

  void onMoveToForgotPassword() async {
    AppRouter.router.push(AppRouter.forgotPasswordPath);
  }

  void onMoveToRegister() async {
    primaryFocus?.unfocus();
    AppRouter.router.push(AppRouter.registerPath);
  }

  String nameValidateCtr(String value) {
    if (value.isEmpty) {
      return currentContext.loc.field_required(currentContext.loc.name);
    }
    if (value.length < 2) {
      return currentContext.loc.format_name_notice;
    }
    return "";
  }

  String emailValidateCtr(String value) {
    final result = Validator.isValidEmail(value);
    if (!result) {
      return currentContext.loc.format_email_notice;
    }
    return "";
  }

  String passwordValidateCtr(String value) {
    if (value.isEmpty) {
      return currentContext.loc.field_required(currentContext.loc.password);
    }
    if (value.length < 6) {
      return currentContext.loc.format_password_notice;
    }
    return "";
  }

  Future<void> onLogin() async {
    try {
      onWillPop = false;
      EasyLoading.show(
        status: currentContext.loc.loading,
        maskType: EasyLoadingMaskType.black,
      );
      if (!_validate()) {
        onWillPop = true;
        EasyLoading.dismiss();
        return;
      }
      final email = emailCtr.text;
      final password = passwordCtr.text;
      final result = await _repo.login(
        postData: {
          "email": email,
          "password": password,
        },
      );
      if (result) {
        EasyLoading.showSuccess(
          currentContext.loc.email_verification_notifcation(email),
        );
        _reset();
      } else {
        EasyLoading.showError(
          "Login failed",
        );
      }
      onWillPop = true;
    } catch (e) {
      showErrorException(e);
      onWillPop = true;
    }
  }

  Future<void> onLoginWithGoogle() async {
    try {
      onWillPop = false;
      EasyLoading.show(
        status: currentContext.loc.loading,
        maskType: EasyLoadingMaskType.black,
      );
      final AuthGoogleProvider authProvider = AuthGoogleProvider();
      final accountSignIn = await (authProvider.signIn());
      if (accountSignIn == null) {
        EasyLoading.showError(currentContext.loc.something_went_wrong);
        return;
      }
      final authentication = await accountSignIn.authentication;

      final result = await _repo.login(
        postData: {
          "token": authentication.accessToken ?? "",
        },
      );
      if (result) {
        EasyLoading.showSuccess(
          currentContext.loc
              .email_verification_notifcation(accountSignIn.email),
        );
      } else {
        EasyLoading.showError(
          "Login failed",
        );
      }
      onWillPop = true;
    } catch (e) {
      showErrorException(e);
      onWillPop = true;
    }
  }

  bool _validate() {
    final emailValidation = emailValidateCtr(emailCtr.text);
    final passwordValidation = passwordValidateCtr(passwordCtr.text);
    if (emailValidation.isNotEmpty || passwordValidation.isNotEmpty) {
      return false;
    }
    return true;
  }

  void _reset() {
    emailCtr.clear();
    passwordCtr.clear();
  }

  @override
  void disposeModel() {
    emailCtr.dispose();
    passwordCtr.dispose();
    super.disposeModel();
  }
}
