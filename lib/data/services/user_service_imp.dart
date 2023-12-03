import 'package:fiver/data/local/preferences.dart';
import 'package:fiver/data/model/info_user_access_token.dart';
import 'package:fiver/data/remote/network/network_url.dart';
import 'package:fiver/domain/services/user_service.dart';

import '../../core/di/locator_service.dart';

class UserServiceImp extends UserService {
  final _pref = locator<Preferences>();

  @override
  Future<bool> register({required Map<String, dynamic> postData}) async {
    final response = await post(
      REGISTER,
      data: postData,
    );
    return response.success;
  }

  @override
  Future<String> getAccessToken() async {
    return _pref.getAccessToken();
  }

  @override
  Future<InfoUserAccessTokenModel> login(
      {required Map<String, String> postData}) async {
    final res = await post(
      LOGIN,
      data: postData,
    );
    return InfoUserAccessTokenModel.fromJson(res.data);
  }

  @override
  Future<UserInfoModel> getMe() async {
    final res = await get(USER_INFO);
    return UserInfoModel.fromJson(res.data["user_info"]);
  }

  @override
  Future<bool> forgotPassword({required String email}) async {
    final res = await post(FORGOT_PASSWORD, data: {"email": email});
    return res.success;
  }

  @override
  Future<InfoUserAccessTokenModel> registerOrLoginSocial(
      {required Map<String, dynamic> postData}) async {
    final res = await post(REGISTER_SOCIAL, data: postData);
    return InfoUserAccessTokenModel.fromJson(res.data);
  }

  @override
  Future<void> logout() async {
    await get(USER_LOGOUT);
  }

  @override
  Future<bool> verifyResetPasswordToken({required String token}) async {
    final res = await post(VERIFY_RESET_TOKEN, data: {
      "token": token,
    });
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
}
