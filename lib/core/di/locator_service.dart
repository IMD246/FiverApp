import 'package:fiver/data/repositories/user_repository_imp.dart';
import 'package:fiver/data/services/user_service_imp.dart';
import 'package:fiver/domain/provider/app_model.dart';
import 'package:fiver/data/local/preferences.dart';
import 'package:fiver/data/repositories/system_repository_imp.dart';
import 'package:fiver/domain/repositories/system_repository.dart';
import 'package:fiver/domain/provider/user_model.dart';
import 'package:fiver/core/res/theme/theme_manager.dart';
import 'package:fiver/domain/repositories/user_repository.dart';
import 'package:fiver/domain/services/user_service.dart';
import 'package:fiver/presentation/auth/register/register_model.dart';
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
