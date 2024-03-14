// ignore_for_file: use_build_context_synchronously

import 'package:fiver/core/app/user_model.dart';
import 'package:fiver/core/base/base_model.dart';
import 'package:fiver/core/extensions/ext_localization.dart';
import 'package:fiver/core/utils/date_utils.dart';
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
  final dateOfBirthCtr = TextEditingControllerCustom();

  final validatorFullNameCtr = ValueNotifier("");
  final validatorDateOfBirthCtr = ValueNotifier("");

  final oldPasswordCtr = TextEditingControllerCustom();
  final newPasswordCtr = TextEditingControllerCustom();
  final repeatPasswordCtr = TextEditingControllerCustom();

  final validatorOldPassword = ValueNotifier("");
  final validatorNewPassword = ValueNotifier("");
  final validatorRepeatPassword = ValueNotifier("");

  void init() {
    fullNameCtr.text = user?.fullName ?? "";
    dateOfBirthCtr.text = user?.dateOfBirth ?? "";

    oldPasswordCtr.listener(
      action: () => setValueNotifier(
        validatorOldPassword,
        ValidatorUtil.passwordValidateCtr(oldPasswordCtr.text),
      ),
    );

    newPasswordCtr.listener(
      action: () => setValueNotifier(
        validatorNewPassword,
        ValidatorUtil.passwordValidateCtr(newPasswordCtr.text),
      ),
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

    fullNameCtr.listener(
      action: () => setValueNotifier(
        validatorFullNameCtr,
        ValidatorUtil.nameValidation(
          fullNameCtr.text,
        ),
      ),
    );

    dateOfBirthCtr.listener(
      action: () {
        setValueNotifier(
          validatorDateOfBirthCtr,
          ValidatorUtil.dateOfBirthValidation(
            dateOfBirthCtr.text,
          ),
        );
      },
    );
  }

  bool _canSavePassword() {
    if (validatorNewPassword.value.isNotEmpty) return false;
    if (validatorOldPassword.value.isNotEmpty) return false;
    if (validatorRepeatPassword.value.isNotEmpty) return false;
    return true;
  }

  bool _canSaveInfo() {
    if (validatorFullNameCtr.value.isNotEmpty) return false;
    if (validatorDateOfBirthCtr.value.isNotEmpty) return false;
    return true;
  }

  void onChangeSalesNotification(bool? value) {}

  void onChangeNewArrivalsNotification(bool? value) {}

  void onChangeDeliveryStatusNotification(bool? value) {}

  @override
  void disposeModel() {
    fullNameCtr.dispose();
    dateOfBirthCtr.dispose();
    oldPasswordCtr.dispose();
    newPasswordCtr.dispose();
    repeatPasswordCtr.dispose();
    validatorDateOfBirthCtr.dispose();
    validatorFullNameCtr.dispose();
    validatorNewPassword.dispose();
    validatorOldPassword.dispose();
    validatorRepeatPassword.dispose();
    super.disposeModel();
  }

  void onSavePassword() async {
    execute(
      () async {
        if (!_canSavePassword()) return;

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
      },
      callBackValidator: (validator) {
        setValueValidator(
          [validator.oldPassword],
          validatorOldPassword,
        );
      },
    );
  }

  void onSaveInfomation() async {
    execute(
      () async {
        if (!_canSaveInfo()) return;

        final date = DateTimeUtils.parseFormatToDate(dateOfBirthCtr.text);

        final result = await _userRepo.updateProfile(
          fullName: fullNameCtr.text,
          dateOfBirth: date.millisecondsSinceEpoch,
        );

        EasyLoading.showSuccess(
          currentContext.loc.infomation_update_success,
          duration: const Duration(seconds: 1),
        );

        locator<UserModel>().onUpdateUserInfo(
          userInfo: result,
          isNotifyChange: false,
        );
      },
      callBackValidator: (validator) {
        setValueValidator(
          validator.dateOfBirth,
          validatorDateOfBirthCtr,
        );
        setValueValidator(
          validator.fullName,
          validatorFullNameCtr,
        );
      },
    );
  }

  void onChangedDatePicker(DateTime? value) {
    if (value == null) return;

    dateOfBirthCtr.text = DateTimeUtils.setFormatDate(value);
  }
}
