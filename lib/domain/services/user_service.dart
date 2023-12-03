import 'package:fiver/core/base/base_service.dart';
import 'package:fiver/data/model/info_user_access_token.dart';

abstract class UserService extends BaseSerivce {
  Future<bool> register({required Map<String, dynamic> postData});
  Future<String> getAccessToken();
  Future<InfoUserAccessTokenModel> login(
      {required Map<String, String> postData});
  Future<UserInfoModel> getMe();
  Future<bool> forgotPassword({required String email});
  Future<InfoUserAccessTokenModel> registerOrLoginSocial(
      {required Map<String, dynamic> postData});
  Future<void> logout();
  Future<bool> verifyResetPasswordToken({required String token});
  Future<bool> resetPassword({
    required String token,
    required String newPassword,
  });
}
