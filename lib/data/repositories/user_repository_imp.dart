import 'package:fiver/core/base/rest_client.dart';
import 'package:fiver/core/provider/auth_provider.dart';
import 'package:fiver/core/utils/util.dart';
import 'package:fiver/data/local/preferences.dart';
import 'package:fiver/data/model/info_user_access_token.dart';
import 'package:fiver/domain/provider/user_model.dart';
import 'package:fiver/domain/repositories/user_repository.dart';
import 'package:fiver/domain/services/user_service.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../core/di/locator_service.dart';

class UserRepositoryImp implements UserRepository {
  final _userService = locator<UserService>();
  final _sharedPreference = locator<Preferences>();
  @override
  String getAccessToken() {
    return _sharedPreference.getAccessToken();
  }

  @override
  Future<void> setAccessToken({required String token}) async {
    await _sharedPreference.setAccessToken(token);
  }

  @override
  Future<bool> register({required Map<String, dynamic> postData}) async {
    return await _userService.register(postData: postData);
  }

  @override
  Future<bool> login({required Map<String, String> postData}) async {
    return await _userService.login(postData: postData);
  }

  @override
  Future<void> getMe({bool isNotifyChange = false}) async {
    final userModel = locator<UserModel>();
    if (!userModel.accessToken.isNullOrEmpty) {
      final user = await _userService.getMe();
      userModel.onUpdateUserInfo(
        userInfo: user,
        isNotifyChange: isNotifyChange,
      );
    }
  }

  @override
  Future<bool> forgotPassword({required String email}) async {
    throw UnimplementedError();
  }

  @override
  Future<UserInfoModel> registerOrLoginSocial({
    required String accessToken,
    required String registerType,
  }) async {
    final result = await _userService.registerOrLoginSocial(
      postData: {
        "register_type": registerType,
        "token": accessToken,
      },
    );
    _setTokenToRestClient(result.accessToken ?? "");
    await setAccessToken(token: result.accessToken ?? "");
    return result.userInfo!;
  }

  void _setTokenToRestClient(String accessToken) {
    RestClient.instance.setToken(accessToken);
  }

  @override
  Future<void> logout({bool isNeedCallApiLogout = false}) async {
    if (isNeedCallApiLogout) {
      await _userService.logout();
    }
    await Future.wait(
      [_sharedPreference.logout(), locator<AuthGoogleProvider>().logout()],
    );

    locator<UserModel>().logout();
  }
}
