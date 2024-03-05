import 'package:dio/dio.dart';

import '../../data/model/info_user_access_token.dart';

abstract class UserRepository {
  Future<bool> register({required Map<String, dynamic> postData});
  String getAccessToken();
  Future<void> setAccessToken({required String token});
  Future<UserInfoModel> login({required Map<String, String> postData});
  Future<bool> forgotPassword({required String email});
  Future<UserInfoModel> registerOrLoginSocial({
    required String accessToken,
    required String registerType,
  });
  Future<void> getMe({bool isNotifyChange = false});
  Future<void> logout({bool isNeedCallApiLogout = false});
  Future<bool> verifyResetPasswordToken({required String token});
  Future<bool> resetPassword({
    required String token,
    required String newPassword,
  });
  Future<void> registerDeviceToken({required String deviceToken});
  Future<void> updateDeviceToken({required String deviceToken});
  String? getDeviceToken();
  Future<bool> uploadAvatar({required FormData formData});
  Future<bool> updatePassword({
    required String oldPassword,
    required String newPassword,
  });
}
