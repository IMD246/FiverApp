import 'package:dio/dio.dart';
import 'package:fiver/core/base/base_model.dart';
import 'package:fiver/core/di/locator_service.dart';
import 'package:fiver/core/extensions/ext_enum.dart';
import 'package:fiver/core/extensions/ext_localization.dart';
import 'package:fiver/core/provider/auth_provider.dart';
import 'package:fiver/core/utils/util.dart';
import 'package:fiver/data/remote/api_reponse/exceptions/api_exception.dart';
import 'package:fiver/domain/provider/user_model.dart';
import 'package:fiver/domain/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../core/enum.dart';
import '../../../core/routes/app_router.dart';
import '../../../core/utils/validation.dart';

class LoginModel extends BaseModel {
  final TextEditingController emailCtr = TextEditingController();
  final TextEditingController passwordCtr = TextEditingController();

  final ValueNotifier<String> emailValidatorCtr = ValueNotifier("");
  final ValueNotifier<String> passwordValidatorCtr = ValueNotifier("");

  final _repo = locator<UserRepository>();

  void init() {
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

  String emailValidateCtr(String value) {
    if (value.isEmpty) {
      return currentContext.loc.field_required(currentContext.loc.email);
    }
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
      locator<UserModel>().onUpdateUserInfo(userInfo: result);
      onWillPop = true;
      EasyLoading.dismiss();
    } catch (e) {
      if (e is DioException && e.response?.statusCode == 422) {
        _handleValidateError(e);
      } else {
        showErrorException(e);
      }
      EasyLoading.dismiss();
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

      final result = await _repo.registerOrLoginSocial(
        accessToken: authentication.accessToken ?? "",
        registerType: RegisterSocialType.google.getTitle(),
      );
      
      EasyLoading.dismiss();
      locator<UserModel>().onUpdateUserInfo(userInfo: result);
      onWillPop = true;
    } catch (e) {
      if (e is ApiException && e.code == 422) {
        locator<AuthGoogleProvider>().logout();
      }
      EasyLoading.dismiss();
      showErrorException(e);
      onWillPop = true;
    }
  }

  bool _validate() {
    final emailValidation = emailValidatorCtr;
    final passwordValidation = passwordValidatorCtr;
    if (emailValidation.value.isNotEmpty ||
        passwordValidation.value.isNotEmpty) {
      return false;
    }
    return true;
  }

  void _handleValidateError(DioException object) {
    final validator = getValidatorFromDioException(object);
    if (validator == null) {
      return;
    }
    setValueValidator(validator.email, emailValidatorCtr);
    setValueValidator(validator.password, passwordValidatorCtr);
  }

  @override
  void disposeModel() {
    emailCtr.dispose();
    passwordCtr.dispose();
    emailValidatorCtr.dispose();
    passwordValidatorCtr.dispose();
    super.disposeModel();
  }
}
