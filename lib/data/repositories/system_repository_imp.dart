import '../../domain/repositories/system_repository.dart';
import '../source/local/preferences.dart';

class SystemRepositoryImp implements SystemRepository {
  final Preferences _preferences;
  SystemRepositoryImp(
    this._preferences,
  );
  @override
  int getTheme() {
    return _preferences.getTheme();
  }

  @override
  Future<void> setTheme(int theme) async {
    return _preferences.setTheme(theme);
  }

  @override
  Future<String> getLanguage() async {
    return await _preferences.getLanguage() ?? "en";
  }
}
