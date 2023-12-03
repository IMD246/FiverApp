// ignore_for_file: use_build_context_synchronously
import 'package:dio/dio.dart';
import 'package:fiver/core/base/base_model.dart';
import 'package:fiver/core/di/locator_service.dart';
import 'package:fiver/core/extensions/ext_localization.dart';
import 'package:fiver/core/utils/util.dart';
import 'package:fiver/domain/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../core/routes/app_router.dart';
import '../../../core/utils/validation.dart';

class ForgotPasswordModel extends BaseModel {
  final TextEditingController emailCtr = TextEditingController();
  final ValueNotifier<String> emailValidatorCtr = ValueNotifier("");
  final _repo = locator<UserRepository>();
  void onBack() async {
    AppRouter.router.pop();
  }

  void init() {
    textFieldListener(
      controller: emailCtr,
      action: () {
        emailValidatorCtr.value = Validator.emailValidateCtr(emailCtr.text);
      },
    );
  }

  String emailValidateCtr(String value) {
    final result = Validator.isValidEmail(value);
    if (!result) {
      return currentContext.loc.format_email_notice;
    }
    return "";
  }

  Future<void> onSend() async {
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
      final result = await _repo.forgotPassword(
        email: email,
      );
      if (result) {
        EasyLoading.showSuccess(
          currentContext.loc.email_forgot_password_notifcation(email),
        );
      } else {
        EasyLoading.showError(
          "Forgot Password failed",
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

  bool _validate() {
    final emailValidation = emailValidatorCtr.value;
    if (emailValidation.isNotEmpty) {
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
  }


  @override
  void disposeModel() {
    emailCtr.dispose();
    emailValidatorCtr.dispose();
    super.disposeModel();
  }
}
