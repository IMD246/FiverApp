import 'package:fiver/core/provider/auth_provider.dart';
import 'package:fiver/data/repositories/category_repository_imp.dart';
import 'package:fiver/data/repositories/common_repository_imp.dart';
import 'package:fiver/data/repositories/user_repository_imp.dart';
import 'package:fiver/core/app/app_model.dart';
import 'package:fiver/data/repositories/system_repository_imp.dart';
import 'package:fiver/data/source/local/preferences.dart';
import 'package:fiver/domain/repositories/category_repository.dart';
import 'package:fiver/domain/repositories/common_repository.dart';
import 'package:fiver/domain/repositories/product_repository.dart';
import 'package:fiver/domain/repositories/system_repository.dart';
import 'package:fiver/core/app/user_model.dart';
import 'package:fiver/core/res/theme/theme_manager.dart';
import 'package:fiver/domain/repositories/user_repository.dart';
import 'package:fiver/presentation/auth/forgot_password/forgot_password_model.dart';
import 'package:fiver/presentation/auth/register/register_model.dart';
import 'package:fiver/presentation/auth/reset_password/reset_password_model.dart';
import 'package:fiver/presentation/main/bag/bag_model.dart';
import 'package:fiver/presentation/main/favorites/favorites_model.dart';
import 'package:fiver/presentation/main/home/home_model.dart';
import 'package:fiver/presentation/main/main_model.dart';
import 'package:fiver/presentation/main/profile/profile_model.dart';
import 'package:fiver/presentation/main/shop/shop_model.dart';
import 'package:fiver/presentation/main/shop_category_detail/shop_category_detail_model.dart';
import 'package:fiver/presentation/view_all_product/view_all_products_model.dart';
import 'package:get_it/get_it.dart';

import '../../data/repositories/product_repository_imp.dart';
import '../../presentation/auth/login/login_model.dart';
import '../../presentation/main/shop_category/shop_category_model.dart';

GetIt locator = GetIt.instance;

Future<void> initLocatorSerivce({bool isTesting = false}) async {
  locator.registerLazySingleton<Preferences>(() => Preferences());
  // await locator<Preferences>().init();
  locator.registerLazySingleton<ThemeManager>(() => ThemeManager());
  locator.registerLazySingleton<AppModel>(() => AppModel());
  locator.registerLazySingleton<UserModel>(() => UserModel());
  locator.registerLazySingleton<AuthGoogleProvider>(() => AuthGoogleProvider());

  // Repositories
  locator.registerLazySingleton<SystemRepository>(
    () => SystemRepositoryImp(locator.get()),
  );
  locator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImp(locator.get()),
  );
  locator.registerLazySingleton<CommonRepository>(
    () => CommonRepositoryImp(),
  );
  locator.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImp(),
  );
  locator.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImp(),
  );

  // ViewModels
  locator.registerFactory(() => RegisterModel());
  locator.registerFactory(() => LoginModel());
  locator.registerFactory(() => ForgotPasswordModel());
  locator.registerFactory(() => MainModel());
  locator.registerFactory(() => ResetPasswordModel());
  locator.registerFactory(() => HomeModel());
  locator.registerFactory(() => ShopModel());
  locator.registerFactory(() => ShopCategoryModel());
  locator.registerFactory(() => ShopCategoryDetailModel());
  locator.registerFactory(() => BagModel());
  locator.registerFactory(() => FavoritesModel());
  locator.registerFactory(() => ProfileModel());
  locator.registerFactory(() => ViewAllProductsModel());
}
