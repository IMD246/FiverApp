import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:share_plus/share_plus.dart';

import '../../core/utils/device_info_util.dart';
import '../data_source/local/isar_db.dart';

import '../../core/app/user_model.dart';
import '../../core/base/base_service.dart';
import '../../core/base/rest_client.dart';
import '../../core/di/locator_service.dart';
import '../../core/provider/auth_provider.dart';
import '../../domain/repositories/user_repository.dart';
import '../data_source/local/preferences.dart';
import '../data_source/remote/network/network_url.dart';
import '../model/info_user_access_token.dart';
import '../model/user_info_model.dart';

class UserRepositoryImp extends BaseSerivce implements UserRepository {
  final Preferences _pref;

  UserRepositoryImp(this._pref);

  @override
  Future<void> init(bool isLogin) async {
    if (isLogin) {
      getMe(isNotifyChange: true);
    }
  }

  @override
  String getAccessToken() {
    return _pref.getAccessToken();
  }

  @override
  Future<void> setAccessToken({required String token}) async {
    await _pref.setAccessToken(token);
  }

  @override
  Future<bool> register({required Map<String, dynamic> postData}) async {
    final response = await post(
      REGISTER,
      data: postData,
    );
    return response.success;
  }

  @override
  Future<UserInfoModel> login({required Map<String, String> postData}) async {
    final response = await post(
      LOGIN,
      data: postData,
    );
    final res = InfoUserAccessTokenModel.fromJson(response.data);
    await Future.wait(
      [
        _setToken(res.accessToken ?? ""),
        _pref.saveUser(res.userInfo!),
      ],
    );
    return res.userInfo!;
  }

  @override
  Future<void> getMe({bool isNotifyChange = false}) async {
    final res = await get(USER_INFO);
    final user = UserInfoModel.fromJson(res.data["user_info"]);
    await _pref.saveUser(user);
    locator<UserModel>().onUpdateUserInfo(
      userInfo: user,
      isNotifyChange: isNotifyChange,
    );
  }

  @override
  Future<bool> forgotPassword({required String email}) async {
    final res = await post(FORGOT_PASSWORD, data: {"email": email});
    return res.success;
  }

  @override
  Future<UserInfoModel> registerOrLoginSocial({
    required String accessToken,
    required String registerType,
  }) async {
    final res = await post(
      REGISTER_SOCIAL,
      data: {
        "register_type": registerType,
        "token": accessToken,
      },
    );

    final info = InfoUserAccessTokenModel.fromJson(res.data);
    Future.wait(
      [
        _pref.saveUser(info.userInfo!),
        _setToken(info.accessToken ?? ""),
      ],
    );
    return info.userInfo!;
  }

  Future<void> _setToken(String accessToken) async {
    RestClient.instance.setToken(accessToken);
    locator<UserModel>().accessToken = accessToken;
    await setAccessToken(token: accessToken);
  }

  Future<void> _optinalCallAPILogout(bool isNeedCallApiLogout) async {
    if (!isNeedCallApiLogout) {
      return;
    }
    await get(USER_LOGOUT);
  }

  @override
  Future<void> logout({bool isNeedCallApiLogout = false}) async {
    locator<UserModel>().logout();
    _optinalCallAPILogout(isNeedCallApiLogout);
    _pref.logout();
    locator<AuthGoogleProvider>().logout();
    locator<IsarDb>().clear();
  }

  @override
  Future<bool> verifyResetPasswordToken({required String token}) async {
    final res = await post(
      VERIFY_RESET_TOKEN,
      data: {
        "token": token,
      },
    );
    return res.success;
  }

  @override
  Future<bool> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    final res = await post(
      RESET_PASSWORD,
      data: {
        "token": token,
        "new_password": newPassword,
      },
    );
    return res.success;
  }

  @override
  Future<void> registerDeviceToken({required String deviceToken}) async {
    final String deviceId = await getDeviceId();
    final String os = getDeviceOS();

    Map<String, dynamic> dataPost = {
      "os": os,
      "deviceId": deviceId,
      "deviceToken": deviceToken
    };

    // await post(REGISTER_DEVICE_TOKEN, data: dataPost);
  }

  @override
  String? getDeviceToken() {
    return _pref.getDeviceToken();
  }

  @override
  Future<void> updateDeviceToken({required String deviceToken}) async {
    await _pref.setDeviceToken(deviceToken);
  }

  @override
  Future<UserInfoModel> uploadAvatar({
    required FormData formData,
  }) async {
    final res = await uploadMedia(
      UPLOAD_AVATAR,
      formData,
    );

    final user = UserInfoModel.fromJson(res.data['user_info']);

    await _pref.saveUser(user);

    return user;
  }

  @override
  Future<bool> updatePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    final res = await post(
      UPDATE_PASSWORD,
      data: {
        "old_password": oldPassword,
        "new_password": newPassword,
      },
    );

    return res.success;
  }

  @override
  Future<UserInfoModel> updateProfile({
    required String fullName,
    required int dateOfBirth,
  }) async {
    final res = await post(
      UPDATE_INFO,
      data: {
        "full_name": fullName,
        "date_of_birth": dateOfBirth,
      },
    );

    final userInfo = UserInfoModel.fromJson(res.data);

    await _pref.saveUser(userInfo);

    return userInfo;
  }

  @override
  UserInfoModel? getUser() {
    return _pref.getUser();
  }
}
