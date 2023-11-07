import 'package:fiver/data/local/preferences.dart';
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
  Future<bool> login({required Map<String, String> postData}) async {
    final response = await post(
      LOGIN,
      data: postData,
    );
    return response.success;
  }

  @override
  Future<bool> loginWithAccessToken({required String accessToken}) {
    // TODO: implement loginWithAccessToken
    throw UnimplementedError();
  }

  @override
  Future<bool> forgotPassword({required String email}) async {
    throw UnimplementedError();
  }
}
