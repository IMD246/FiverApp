// ignore_for_file: use_build_context_synchronously
import 'package:fiver/core/base/base_model.dart';
import 'package:fiver/core/di/locator_service.dart';
import 'package:fiver/core/extensions/ext_localization.dart';
import 'package:fiver/core/provider/auth_provider.dart';
import 'package:fiver/data/model/register_info_model.dart';
import 'package:fiver/domain/provider/user_model.dart';
import 'package:fiver/domain/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../core/routes/app_router.dart';
import '../../../core/utils/validation.dart';

class RegisterModel extends BaseModel {
  final TextEditingController nameCtr = TextEditingController();
  final TextEditingController emailCtr = TextEditingController();
  final TextEditingController passwordCtr = TextEditingController();
  final _repo = locator<UserRepository>();

  void onMoveToLogin() async {
    if (AppRouter.router.canPop()) {
      AppRouter.router.pop();
    } else {
      AppRouter.router.pushReplacementNamed(AppRouter.loginName);
      locator<UserModel>().updateInitRoute("");
    }
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

  Future<void> onRegister() async {
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
      final name = nameCtr.text;
      final email = emailCtr.text;
      final password = passwordCtr.text;

      final postData = RegisterInfoModel(
        name: name,
        email: email,
        password: password,
      ).toJson();

      final result = await _repo.register(
        postData: postData,
      );
      if (result) {
        EasyLoading.showSuccess(
          currentContext.loc.email_verification_notifcation(email),
        );
        _reset();
        onMoveToLogin();
      } else {
        EasyLoading.showError(
          "Register failed",
        );
      }
      onWillPop = true;
    } catch (e) {
      showErrorException(e);
      onWillPop = true;
    }
  }

  Future<void> onRegisterWithGoogle() async {
    try {
      onWillPop = false;
      EasyLoading.show(
        status: currentContext.loc.loading,
        maskType: EasyLoadingMaskType.black,
      );
      final AuthGoogleProvider authProvider = AuthGoogleProvider();
      await authProvider.logout();
      final accountSignIn = await (authProvider.signIn());
      if (accountSignIn == null) {
        EasyLoading.showError(currentContext.loc.something_went_wrong);
        return;
      }
      final authentication = await accountSignIn.authentication;
      final result = await _repo.register(
        postData: {
          "access_token": authentication.accessToken,
        },
      );
      if (result) {
        EasyLoading.showSuccess(
          currentContext.loc
              .email_verification_notifcation(accountSignIn.email),
        );
        onMoveToLogin();
      } else {
        EasyLoading.showError(
          "Register failed",
        );
      }
      onWillPop = true;
    } catch (e) {
      showErrorException(e);
      onWillPop = true;
    }
  }

  bool _validate() {
    final nameValidation = nameValidateCtr(nameCtr.text);
    final emailValidation = emailValidateCtr(emailCtr.text);
    final passwordValidation = passwordValidateCtr(passwordCtr.text);
    if (nameValidation.isNotEmpty ||
        emailValidation.isNotEmpty ||
        passwordValidation.isNotEmpty) {
      return false;
    }
    return true;
  }

  void _reset() {
    emailCtr.clear();
    nameCtr.clear();
    passwordCtr.clear();
  }

  @override
  void disposeModel() {
    nameCtr.dispose();
    emailCtr.dispose();
    passwordCtr.dispose();
    super.disposeModel();
  }
}
