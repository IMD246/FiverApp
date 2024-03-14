// ignore_for_file: use_build_context_synchronously

import 'package:fiver/core/app/user_model.dart';
import 'package:fiver/core/base/base_model.dart';
import 'package:fiver/core/di/locator_service.dart';
import 'package:fiver/core/extensions/ext_enum.dart';
import 'package:fiver/core/extensions/ext_localization.dart';
import 'package:fiver/core/provider/auth_provider.dart';
import 'package:fiver/core/utils/text_field_editing_controller_custom.dart';
import 'package:fiver/core/utils/util.dart';
import 'package:fiver/data/data_source/remote/api_reponse/exceptions/api_exception.dart';
import 'package:fiver/domain/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../core/enum.dart';
import '../../../core/routes/app_router.dart';
import '../../../core/utils/validator_util.dart';

class LoginModel extends BaseModel {
  final emailCtr = TextEditingControllerCustom();
  final passwordCtr = TextEditingControllerCustom();

  final ValueNotifier<String> emailValidatorCtr = ValueNotifier("");
  final ValueNotifier<String> passwordValidatorCtr = ValueNotifier("");

  final _repo = locator<UserRepository>();

  void init() {
    emailCtr.listener(action: () {
      emailValidatorCtr.value = ValidatorUtil.emailValidateCtr(emailCtr.text);
    });

    passwordCtr.listener(action: () {
      passwordValidatorCtr.value =
          ValidatorUtil.passwordValidateCtr(passwordCtr.text);
    });
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
    final result = ValidatorUtil.isValidEmail(value);
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

  void onLogin() {
    execute(
      () async {
        if (!_validate()) {
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
      },
      callBackValidator: (validator) {
        setValueValidator(validator.email, emailValidatorCtr);
        setValueValidator(validator.password, passwordValidatorCtr);
      },
    );
  }

  void onLoginWithGoogle() {
    execute(
      () async {
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

        locator<UserModel>().onUpdateUserInfo(userInfo: result);
      },
      customOnErrorFunction: (e) {
        if (e is ApiException && e.code == 422) {
          locator<AuthGoogleProvider>().logout();
        } else {
          showErrorException(e);
        }
      },
    );
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

  @override
  void disposeModel() {
    emailCtr.dispose();
    passwordCtr.dispose();
    emailValidatorCtr.dispose();
    passwordValidatorCtr.dispose();
    super.disposeModel();
  }
}
