abstract class SystemRepository {
  int getTheme();
  Future<void> setTheme(int theme);
  Future<String> getLanguage();
}
