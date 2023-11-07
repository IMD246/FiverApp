import 'package:fiven/data/repositories/user_repository_imp.dart';
import 'package:fiven/data/services/user_service_imp.dart';
import 'package:fiven/domain/provider/app_model.dart';
import 'package:fiven/data/local/preferences.dart';
import 'package:fiven/data/repositories/system_repository_imp.dart';
import 'package:fiven/domain/repositories/system_repository.dart';
import 'package:fiven/domain/provider/user_model.dart';
import 'package:fiven/core/res/theme/theme_manager.dart';
import 'package:fiven/domain/repositories/user_repository.dart';
import 'package:fiven/domain/services/user_service.dart';
import 'package:fiven/presentation/auth/register/register_model.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void initLocatorSerivce() {
  locator.registerLazySingleton<Preferences>(() => Preferences());
  locator.registerLazySingleton<ThemeManager>(() => ThemeManager());
  locator.registerLazySingleton<AppModel>(() => AppModel());
  locator.registerLazySingleton<UserModel>(() => UserModel());

  // Services
  locator.registerLazySingleton<UserService>(() => UserServiceImp());

  // Repositories
  locator.registerLazySingleton<SystemRepository>(
    () => SystemRepositoryImp(locator<Preferences>()),
  );
  locator.registerLazySingleton<UserRepository>(() => UserRepositoryImp());

  // ViewModels
  locator.registerFactory(() => RegisterModel());
}
