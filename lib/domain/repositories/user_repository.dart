import 'package:dio/dio.dart';
import '../../data/model/user_info_model.dart';

abstract class UserRepository {
  Future<void> init(bool isLogin);
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
  Future<UserInfoModel> uploadAvatar({required FormData formData});
  Future<bool> updatePassword({
    required String oldPassword,
    required String newPassword,
  });
  Future<bool> updateProfile({
    required String fullName,
    required int dateOfBirth,
  });
  UserInfoModel? getUser();
}
