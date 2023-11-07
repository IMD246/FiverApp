import 'package:fiven/domain/repositories/user_repository.dart';
import 'package:fiven/domain/services/user_service.dart';

import '../../core/di/locator_service.dart';
import '../model/register_info_model.dart';

class UserRepositoryImp implements UserRepository {
  final _userService = locator<UserService>();

  @override
  Future<String> getAccessToken() async {
    return await _userService.getAccessToken();
  }

  @override
  Future<bool> register({required RegisterInfoModel registerInfoModel}) async {
    return await _userService.register(registerInfoModel: registerInfoModel);
  }
}
