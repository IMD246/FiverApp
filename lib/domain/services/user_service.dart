import 'package:fiver/core/base/base_service.dart';

abstract class UserService extends BaseSerivce {
  Future<bool> register({required Map<String, dynamic> postData});
  Future<String> getAccessToken();
  Future<bool> login({required Map<String, String> postData});
  Future<bool> loginWithAccessToken({
    required String accessToken,
  });
  Future<bool> forgotPassword({required String email});
}
