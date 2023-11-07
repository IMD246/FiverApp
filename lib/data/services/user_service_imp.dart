import 'package:fiven/data/local/preferences.dart';
import 'package:fiven/data/remote/network/network_url.dart';
import 'package:fiven/domain/services/user_service.dart';

import '../../core/di/locator_service.dart';
import '../model/register_info_model.dart';

class UserServiceImp extends UserService {
  final _pref = locator<Preferences>();
  @override
  Future<bool> register({required RegisterInfoModel registerInfoModel}) async {
    final response = await post(
      REGISTER,
      data: registerInfoModel.toJson(),
    );
    return response.success;
  }

  @override
  Future<String> getAccessToken() async {
    return _pref.getAccessToken();
  }
}
