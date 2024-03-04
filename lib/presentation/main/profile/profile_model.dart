// ignore_for_file: use_build_context_synchronously

import 'package:fiver/core/extensions/ext_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/base/base_model.dart';
import '../../../core/di/locator_service.dart';
import '../../../core/utils/media_util.dart';
import '../../../domain/repositories/user_repository.dart';

class ProfileModel extends BaseModel {
  final _userRepository = locator<UserRepository>();
  final ValueNotifier<XFile?> avatar = ValueNotifier(null);

  void onLogout() async {
    await _userRepository.logout(isNeedCallApiLogout: true);
  }

  void onUpdateAvatar() async {
    final resultPicker = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );

    if (resultPicker == null) return;

    if (await MediaUtils.checkFileSizeIsInvalid(resultPicker)) {
      EasyLoading.showError(
        currentContext.loc.error_size_file(10),
        duration: const Duration(seconds: 1),
      );
      return;
    }

    avatar.value = resultPicker;

    final result = await _userRepository.uploadAvatar(
      formData: await MediaUtils.settingFormDataForAvatarUpload(
        avatar.value?.path ?? "",
        avatar.value?.name ?? "",
      ),
    );
    if (result) {
      _userRepository.getMe(isNotifyChange: false);
    }
  }

  @override
  void disposeModel() {
    avatar.dispose();
    super.disposeModel();
  }
}
