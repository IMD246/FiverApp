import 'package:fiven/domain/viewModel/app_model.dart';
import 'package:fiven/base/rest_client.dart';
import 'package:fiven/data/local/preferences.dart';
import 'package:fiven/data/remote/network/network_url.dart';
import 'package:fiven/data/repositories/system_repository_imp.dart';
import 'package:fiven/domain/repositories/system_repository.dart';
import 'package:fiven/domain/viewModel/user_model.dart';
import 'package:fiven/res/theme/theme_manager.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void initLocatorSerivce() {
  locator.registerLazySingleton<Preferences>(() => Preferences());
  locator.registerLazySingleton<ThemeManager>(() => ThemeManager());
  locator.registerLazySingleton<AppModel>(() => AppModel());
  locator.registerLazySingleton<UserModel>(() => UserModel());
  // Repositories
  locator.registerLazySingleton<SystemRepository>(() => SystemRepositoryImp());
  // ViewModels
  // locator.registerFactory(() => null);

  // Models

  locator.registerSingleton<RestClient>(RestClient());
}
