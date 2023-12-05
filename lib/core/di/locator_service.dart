import 'package:fiver/core/provider/auth_provider.dart';
import 'package:fiver/data/repositories/user_repository_imp.dart';
import 'package:fiver/core/app/app_model.dart';
import 'package:fiver/data/repositories/system_repository_imp.dart';
import 'package:fiver/data/source/local/preferences.dart';
import 'package:fiver/domain/repositories/system_repository.dart';
import 'package:fiver/core/app/user_model.dart';
import 'package:fiver/core/res/theme/theme_manager.dart';
import 'package:fiver/domain/repositories/user_repository.dart';
import 'package:fiver/presentation/auth/forgot_password/forgot_password_model.dart';
import 'package:fiver/presentation/auth/register/register_model.dart';
import 'package:fiver/presentation/auth/reset_password/reset_password_model.dart';
import 'package:fiver/presentation/main/main_model.dart';
import 'package:get_it/get_it.dart';

import '../../presentation/auth/login/login_model.dart';

GetIt locator = GetIt.instance;

Future<void> initLocatorSerivce({bool isTesting = false}) async {
  locator.registerLazySingleton<Preferences>(() => Preferences());
  await locator<Preferences>().init();
  locator.registerLazySingleton<ThemeManager>(() => ThemeManager());
  locator.registerLazySingleton<AppModel>(() => AppModel());
  locator.registerLazySingleton<UserModel>(() => UserModel());
  locator.registerLazySingleton<AuthGoogleProvider>(() => AuthGoogleProvider());

  // Repositories
  locator.registerLazySingleton<SystemRepository>(
    () => SystemRepositoryImp(locator<Preferences>()),
  );
  locator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImp(locator<Preferences>()),
  );

  // ViewModels
  locator.registerFactory(() => RegisterModel());
  locator.registerFactory(() => LoginModel());
  locator.registerFactory(() => ForgotPasswordModel());
  locator.registerFactory(() => MainModel());
  locator.registerFactory(() => ResetPasswordModel());
}
