import '../../data/model/register_info_model.dart';

abstract class UserRepository {
  Future<bool> register({required RegisterInfoModel registerInfoModel});
  Future<String> getAccessToken();
}
