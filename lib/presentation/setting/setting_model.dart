// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:fiver/core/base/base_model.dart';
import 'package:fiver/core/extensions/ext_localization.dart';
import 'package:fiver/core/utils/text_field_editing_controller_custom.dart';
import 'package:fiver/core/utils/validator_util.dart';
import 'package:fiver/domain/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../core/di/locator_service.dart';
import '../../core/utils/util.dart';

class SettingModel extends BaseModel {
  final _userRepo = locator<UserRepository>();

  final fullNameCtr = TextEditingControllerCustom();
  final dateOfBirth = ValueNotifier("");

  final validatorFullNameCtr = ValueNotifier("");

  final oldPasswordCtr = TextEditingControllerCustom();
  final newPasswordCtr = TextEditingControllerCustom();
  final repeatPasswordCtr = TextEditingControllerCustom();

  final validatorOldPassword = ValueNotifier("");
  final validatorNewPassword = ValueNotifier("");
  final validatorRepeatPassword = ValueNotifier("");

  void init() {
    oldPasswordCtr.listener(
      action: () => setValueNotifier(validatorOldPassword,
          ValidatorUtil.passwordValidateCtr(oldPasswordCtr.text)),
    );

    newPasswordCtr.listener(
      action: () => setValueNotifier(validatorNewPassword,
          ValidatorUtil.passwordValidateCtr(newPasswordCtr.text)),
    );

    repeatPasswordCtr.listener(
      action: () => setValueNotifier(
        validatorRepeatPassword,
        ValidatorUtil.confirmPasswordValidateCtr(
          newPasswordCtr.text,
          repeatPasswordCtr.text,
        ),
      ),
    );
  }

  bool _canSavePassword() {
    if (validatorNewPassword.value.isNotEmpty) return false;
    if (validatorOldPassword.value.isNotEmpty) return false;
    if (validatorRepeatPassword.value.isNotEmpty) return false;
    return true;
  }

  void onChangeSalesNotification(bool? value) {}

  void onChangeNewArrivalsNotification(bool? value) {}

  void onChangeDeliveryStatusNotification(bool? value) {}

  @override
  void disposeModel() {
    fullNameCtr.dispose();
    dateOfBirth.dispose();
    validatorFullNameCtr.dispose();
    validatorNewPassword.dispose();
    validatorOldPassword.dispose();
    validatorRepeatPassword.dispose();
    super.disposeModel();
  }

  void onSavePassword() async {
    if (!_canSavePassword()) return;

    onWillPop = false;

    try {
      EasyLoading.show(
        status: currentContext.loc.loading,
        maskType: EasyLoadingMaskType.black,
      );

      final result = await _userRepo.updatePassword(
        oldPassword: oldPasswordCtr.text,
        newPassword: newPasswordCtr.text,
      );

      if (result) {
        EasyLoading.showSuccess(
          currentContext.loc.password_update_success,
          duration: const Duration(seconds: 1),
        );
        _userRepo.logout(isNeedCallApiLogout: true);
      }
    } catch (e) {
      if (e is DioException && e.response?.statusCode == 422) {
        _handleValidateError(e);
      } else {
        showErrorException(e);
      }
    } finally {
      onWillPop = true;
      EasyLoading.dismiss();
    }
  }

  void _handleValidateError(DioException object) {
    final validator = getValidatorFromDioException(object);
    if (validator == null) {
      return;
    }
    setValueValidator([validator.oldPassword], validatorOldPassword);
  }
}
