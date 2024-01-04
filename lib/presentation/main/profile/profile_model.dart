import '../../../core/base/base_model.dart';
import '../../../core/di/locator_service.dart';
import '../../../domain/repositories/user_repository.dart';

class ProfileModel extends BaseModel {
  final _userRepository = locator<UserRepository>();

  void onLogout()async{
    await _userRepository.logout(isNeedCallApiLogout: true);
  }
}
