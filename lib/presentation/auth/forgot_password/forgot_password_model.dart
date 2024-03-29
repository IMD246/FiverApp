// ignore_for_file: use_build_context_synchronously
import 'package:fiver/core/base/base_model.dart';
import 'package:fiver/core/di/locator_service.dart';
import 'package:fiver/core/extensions/ext_localization.dart';
import 'package:fiver/core/utils/text_field_editing_controller_custom.dart';
import 'package:fiver/domain/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../core/routes/app_router.dart';
import '../../../core/utils/validator_util.dart';

class ForgotPasswordModel extends BaseModel {
  final emailCtr = TextEditingControllerCustom();
  final ValueNotifier<String> emailValidatorCtr = ValueNotifier("");
  final _repo = locator<UserRepository>();

  void onBack() async {
    AppRouter.router.pop();
  }

  void init() {
    emailCtr.listener(action: () {
      emailValidatorCtr.value = ValidatorUtil.emailValidateCtr(emailCtr.text);
    });
  }

  String emailValidateCtr(String value) {
    final result = ValidatorUtil.isValidEmail(value);
    if (!result) {
      return currentContext.loc.format_email_notice;
    }
    return "";
  }

  void onSend() {
    execute(() async{
      if (!_validate()) {
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
          currentContext.loc.forgot_password_fail,
        );
      }
    });
  }

  bool _validate() {
    final emailValidation = emailValidatorCtr.value;
    if (emailValidation.isNotEmpty) {
      return false;
    }
    return true;
  }

  @override
  void disposeModel() {
    emailCtr.dispose();
    emailValidatorCtr.dispose();
    super.disposeModel();
  }
}
