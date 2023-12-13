import '../../core/base/base_service.dart';
import '../../core/base/rest_client.dart';
import '../../core/provider/auth_provider.dart';
import '../../core/utils/util.dart';
import '../model/info_user_access_token.dart';
import '../../core/app/user_model.dart';
import '../../domain/repositories/user_repository.dart';
import '../../core/di/locator_service.dart';
import '../data_source/local/preferences.dart';
import '../data_source/remote/network/network_url.dart';

class UserRepositoryImp extends BaseSerivce implements UserRepository {
  final Preferences _pref;

  UserRepositoryImp(this._pref);

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
    await _setToken(res.accessToken ?? "");
    return res.userInfo!;
  }

  @override
  Future<void> getMe({bool isNotifyChange = false}) async {
    final userModel = locator<UserModel>();
    final accessToken = locator<Preferences>().getAccessToken();
    if (!accessToken.isNullOrEmpty) {
      final res = await get(USER_INFO);
      final user = UserInfoModel.fromJson(res.data["user_info"]);
      userModel.onUpdateUserInfo(
        userInfo: user,
        isNotifyChange: isNotifyChange,
      );
    }
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

    await _setToken(info.accessToken ?? "");
    return info.userInfo!;
  }

  Future<void> _setToken(String accessToken) async {
    RestClient.instance.setToken(accessToken);
    await setAccessToken(token: accessToken);
  }

  @override
  Future<void> logout({bool isNeedCallApiLogout = false}) async {
    if (isNeedCallApiLogout) {
      await get(USER_LOGOUT);
    }
    await Future.wait(
      [
        _pref.logout(),
        locator<AuthGoogleProvider>().logout(),
      ],
    );
    locator<UserModel>().logout();
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
}
