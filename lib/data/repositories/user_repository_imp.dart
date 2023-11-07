import 'package:fiver/domain/repositories/user_repository.dart';
import 'package:fiver/domain/services/user_service.dart';

import '../../core/di/locator_service.dart';

class UserRepositoryImp implements UserRepository {
  final _userService = locator<UserService>();

  @override
  Future<String> getAccessToken() async {
    return await _userService.getAccessToken();
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
  Future<bool> loginWithAccessToken({required String accessToken}) {
    // TODO: implement loginWithAccessToken
    throw UnimplementedError();
  }
}
