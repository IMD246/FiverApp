// ignore_for_file: use_build_context_synchronously

import 'package:fiver/core/app/user_model.dart';
import 'package:fiver/core/extensions/ext_localization.dart';
import 'package:fiver/core/utils/collection_util.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/base/base_model.dart';
import '../../../core/di/locator_service.dart';
import '../../../core/utils/media_util.dart';
import '../../../domain/repositories/user_repository.dart';

class ProfileModel extends BaseModel {
  final _userRepository = locator<UserRepository>();

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

    final userInfo = await _userRepository.uploadAvatar(
      formData: await MediaUtils.settingFormDataForAvatarUpload(
        resultPicker.path,
        resultPicker.name,
      ),
    );

    if (!userInfo.isNullOrEmpty) {
      locator<UserModel>().onUpdateUserInfo(
        userInfo: userInfo,
        isNotifyChange: false,
      );
    }
  }
}
