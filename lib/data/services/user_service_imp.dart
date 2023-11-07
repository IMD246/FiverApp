import 'package:fiver/data/local/preferences.dart';
import 'package:fiver/data/remote/network/network_url.dart';
import 'package:fiver/domain/services/user_service.dart';

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
