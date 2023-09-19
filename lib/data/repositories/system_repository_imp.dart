import 'package:fiven/data/local/preferences.dart';
import 'package:fiven/domain/repositories/system_repository.dart';

class SystemRepositoryImp implements SystemRepository {
  final Preferences preferences;
  SystemRepositoryImp(
    this.preferences,
  );
  @override
  int getTheme() {
    return preferences.getTheme();
  }

  @override
  Future<void> setTheme(int theme) async {
    return preferences.setTheme(theme);
  }
}
