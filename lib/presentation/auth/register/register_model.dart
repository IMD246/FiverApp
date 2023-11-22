// ignore_for_file: use_build_context_synchronously
import 'package:dio/dio.dart';
import 'package:fiver/core/base/base_model.dart';
import 'package:fiver/core/di/locator_service.dart';
import 'package:fiver/core/enum.dart';
import 'package:fiver/core/extensions/ext_enum.dart';
import 'package:fiver/core/extensions/ext_localization.dart';
import 'package:fiver/core/provider/auth_provider.dart';
import 'package:fiver/core/utils/util.dart';
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

  final ValueNotifier<String> nameValidatorCtr = ValueNotifier("");
  final ValueNotifier<String> emailValidatorCtr = ValueNotifier("");
  final ValueNotifier<String> passwordValidatorCtr = ValueNotifier("");

  final _authGoogleProvider = AuthGoogleProvider();
  final _repo = locator<UserRepository>();

  void init() {
    textFieldListener(
      controller: nameCtr,
      action: () {
        nameValidatorCtr.value = Validator.nameValidation(nameCtr.text);
      },
    );

    textFieldListener(
      controller: emailCtr,
      action: () {
        emailValidatorCtr.value = Validator.emailValidateCtr(emailCtr.text);
      },
    );

    textFieldListener(
      controller: passwordCtr,
      action: () {
        passwordValidatorCtr.value =
            Validator.passwordValidateCtr(passwordCtr.text);
      },
    );
  }

  void onMoveToLogin() async {
    if (AppRouter.router.canPop()) {
      AppRouter.router.pop();
    } else {
      AppRouter.router.pushReplacementNamed(AppRouter.loginName);
      locator<UserModel>().updateInitRoute("");
    }
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
        _reset();
        EasyLoading.showSuccess(
          currentContext.loc.email_verification_notifcation(email),
          duration: Duration(seconds: 3),
        );
      }
      onWillPop = true;
    } catch (e) {
      if (e is DioException && e.response?.statusCode == 422) {
        _handleValidateError(e);
      } else {
        showErrorException(e);
      }
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
      await _authGoogleProvider.logout();
      final accountSignIn = await _authGoogleProvider.signIn();
      if (accountSignIn == null) {
        EasyLoading.showError(currentContext.loc.something_went_wrong);
        return;
      }
      final authentication = await accountSignIn.authentication;
      final result = await _repo.registerOrLoginSocial(
        accessToken: authentication.accessToken ?? "",
        registerType: RegisterSocialType.google.getTitle(),
      );
      locator<UserModel>().onUpdateUserInfo(userInfo: result);
      onWillPop = true;
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      showErrorException(e);
      onWillPop = true;
    }
  }

  bool _validate() {
    final nameValidation = nameValidatorCtr;
    final emailValidation = emailValidatorCtr;
    final passwordValidation = passwordValidatorCtr;
    if (nameValidation.value.isNotEmpty ||
        emailValidation.value.isNotEmpty ||
        passwordValidation.value.isNotEmpty) {
      return false;
    }
    return true;
  }

  void _reset() {
    emailCtr.clear();
    nameCtr.clear();
    passwordCtr.clear();
  }

  void _handleValidateError(DioException object) {
    final validator = getValidatorFromDioException(object);
    if(validator == null)
    {
      return;
    }
    setValueValidator(validator.email, emailValidatorCtr);
    setValueValidator(validator.fullName, nameValidatorCtr);
    setValueValidator(validator.password, passwordValidatorCtr);
  }

  @override
  void disposeModel() {
    nameCtr.dispose();
    emailCtr.dispose();
    passwordCtr.dispose();
    nameValidatorCtr.dispose();
    emailValidatorCtr.dispose();
    passwordValidatorCtr.dispose();
    super.disposeModel();
  }
}
