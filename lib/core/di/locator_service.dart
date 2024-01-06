import 'package:fiver/presentation/product_detail.dart/product_detail_model.dart';

import '../../data/repositories/remote/remote_review_repository.dart';
import '../../data/repositories/review_repository_imp.dart';
import '../../domain/repositories/review_repository.dart';
import '../../presentation/rating_and_review/rating_and_review_model.dart';
import 'package:get_it/get_it.dart';

import '../../data/data_source/local/isar_db.dart';
import '../../data/data_source/local/preferences.dart';
import '../../data/repositories/category_repository_imp.dart';
import '../../data/repositories/common_repository_imp.dart';
import '../../data/repositories/local/local_common_repository.dart';
import '../../data/repositories/product_repository_imp.dart';
import '../../data/repositories/remote/remote_common_repository.dart';
import '../../data/repositories/system_repository_imp.dart';
import '../../data/repositories/user_repository_imp.dart';
import '../../domain/repositories/category_repository.dart';
import '../../domain/repositories/common_repository.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/repositories/system_repository.dart';
import '../../domain/repositories/user_repository.dart';
import '../../presentation/auth/forgot_password/forgot_password_model.dart';
import '../../presentation/auth/login/login_model.dart';
import '../../presentation/auth/register/register_model.dart';
import '../../presentation/auth/reset_password/reset_password_model.dart';
import '../../presentation/brand/brand_model.dart';
import '../../presentation/filter/filter_model.dart';
import '../../presentation/main/bag/bag_model.dart';
import '../../presentation/main/favorites/favorites_model.dart';
import '../../presentation/main/home/home_model.dart';
import '../../presentation/main/main_model.dart';
import '../../presentation/main/profile/profile_model.dart';
import '../../presentation/main/shop/shop_model.dart';
import '../../presentation/main/shop_category/shop_category_model.dart';
import '../../presentation/main/shop_category_detail/shop_category_detail_model.dart';
import '../../presentation/view_all_product/view_all_products_model.dart';
import '../app/app_model.dart';
import '../app/user_model.dart';
import '../constant/constants.dart';
import '../provider/auth_provider.dart';
import '../res/theme/theme_manager.dart';

GetIt locator = GetIt.instance;

Future<void> initLocatorSerivce() async {
  locator.registerLazySingleton<Preferences>(() => Preferences());
  locator.registerLazySingleton<IsarDb>(() => IsarDb());
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
  locator.registerLazySingleton<ReviewRepository>(
    () => ReviewRepositoryImp(),
  );

  // Remote Repositories
  locator.registerLazySingleton<CommonRepository>(
    () => RemoteCommonRepository(),
    instanceName: Constants.instanceRemoteCommonRepository,
  );

  locator.registerLazySingleton<ReviewRepository>(
    () => RemoteReviewRepository(),
    instanceName: Constants.instanceRemoteReviewRepository,
  );

  // Local Repositories
  locator.registerLazySingleton<CommonRepository>(
    () => LocalCommonRepository(),
    instanceName: Constants.instanceLocalCommonRepository,
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
  locator.registerFactory(() => FilterModel());
  locator.registerFactory(() => BrandModel());
  locator.registerFactory(() => RatingAndReviewModel());
  locator.registerFactory(() => ProductDetailModel());
}
