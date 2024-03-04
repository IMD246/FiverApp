import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/base/base_model.dart';
import '../../../core/di/locator_service.dart';
import '../../../domain/repositories/user_repository.dart';

class ProfileModel extends BaseModel {
  final _userRepository = locator<UserRepository>();
  final ValueNotifier<XFile?> avatar = ValueNotifier(null);

  void onLogout() async {
    await _userRepository.logout(isNeedCallApiLogout: true);
  }

  void onUpdateAvatar() async {
    final _result = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 60,
      maxWidth: 64,
      maxHeight: 64,
    );

    if (_result == null) return;

    avatar.value = _result;

    // final res = _userRepository.uploadAvatar(
    //   formData: MediaUtils.settingFormDataForAvatarUpload(
    //     avatar.value?.path ?? "",
    //     avatar.value?.name ?? "",
    //   ),
    // );
  }

  @override
  void disposeModel() {
    avatar.dispose();
    super.disposeModel();
  }
}
