// ignore_for_file: use_build_context_synchronously
import 'package:dio/dio.dart';
import 'package:fiver/core/base/base_model.dart';
import 'package:fiver/core/di/locator_service.dart';
import 'package:fiver/core/extensions/ext_localization.dart';
import 'package:fiver/core/utils/text_field_editing_controller_custom.dart';
import 'package:fiver/domain/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../core/routes/app_router.dart';
import '../../../core/utils/validator_util.dart';

class ResetPasswordModel extends BaseModel {
  final newPasswordCtr = TextEditingControllerCustom();
  final confirmPasswordCtr = TextEditingControllerCustom();

  final ValueNotifier<String> newPasswordValidatorCtr = ValueNotifier("");
  final ValueNotifier<String> confirmPasswordValidatorCtr = ValueNotifier("");

  final _repo = locator<UserRepository>();

  String token = "";

  void init(String token) {
    this.token = token;
    _checkTokenExpire(token);

    newPasswordCtr.listener(action: () {
      newPasswordValidatorCtr.value =
          ValidatorUtil.passwordValidateCtr(newPasswordCtr.text);
    });

    confirmPasswordCtr.listener(action: () {
      confirmPasswordValidatorCtr.value =
          ValidatorUtil.confirmPasswordValidateCtr(
        newPasswordCtr.text,
        confirmPasswordCtr.text,
      );
    });
  }

  void _checkTokenExpire(String token) async {
    if (token.isEmpty) {
      onMoveToLogin();
    }

    execute(
      () async {
        await _repo.verifyResetPasswordToken(token: token);
      },
      needShowLoading: false,
      customOnErrorFunction: (e) {
        if (e is DioException) {
          EasyLoading.showError(
            currentContext.loc.verify_reset_password_token_error,
            duration: const Duration(seconds: 2),
          );
        } else {
          showErrorException(e);
        }
        onMoveToLogin();
      },
    );
  }

  Future<bool> onMoveToLogin() async {
    if (AppRouter.router.canPop()) {
      AppRouter.router.pop();
      return true;
    } else {
      AppRouter.router.go(AppRouter.loginPath);
      return false;
    }
  }

  Future<void> onResetPassword() async {
    execute(
      () async {
        if (!_validate()) {
          return;
        }
        final newPassword = newPasswordCtr.text;

        final result = await _repo.resetPassword(
          token: token,
          newPassword: newPassword,
        );

        if (result) {
          EasyLoading.showSuccess(
            currentContext.loc.reset_password_success_notification,
            duration: const Duration(seconds: 1),
          );

          onMoveToLogin();
        } else {
          EasyLoading.showError(
            currentContext.loc.reset_password_failed_notification,
          );
        }
      },
    );
  }

  bool _validate() {
    final newPasswordValidation = newPasswordValidatorCtr.value;
    final confirmPasswordValidation = confirmPasswordValidatorCtr.value;
    if (newPasswordValidation.isNotEmpty ||
        confirmPasswordValidation.isNotEmpty) {
      return false;
    }
    return true;
  }

  @override
  void disposeModel() {
    newPasswordCtr.dispose();
    newPasswordValidatorCtr.dispose();
    confirmPasswordCtr.dispose();
    confirmPasswordValidatorCtr.dispose();
    super.disposeModel();
  }
}
