import 'package:fiven/core/base/base_service.dart';

import '../../data/model/register_info_model.dart';

abstract class UserService extends BaseSerivce {
  Future<bool> register({required RegisterInfoModel registerInfoModel});
  Future<String> getAccessToken();
}
