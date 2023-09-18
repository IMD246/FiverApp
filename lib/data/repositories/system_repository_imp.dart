import 'package:fiven/data/local/preferences.dart';
import 'package:fiven/domain/repositories/system_repository.dart';

import '../../di/locator_service.dart';

class SystemRepositoryImp implements SystemRepository {
  final _preferences = locator<Preferences>();
  @override
  int getTheme() {
    return _preferences.getTheme();
  }

  @override
  Future<void> setTheme(int theme) async {
    return _preferences.setTheme(theme);
  }
}
