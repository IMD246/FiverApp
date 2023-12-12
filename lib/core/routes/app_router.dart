import '../di/locator_service.dart';
import '../enum.dart';
import '../app/app_model.dart';
import '../app/user_model.dart';
import '../../data/model/filter_ui_model.dart';
import '../../presentation/auth/forgot_password/forgot_password_page.dart';
import '../../presentation/auth/login/login_page.dart';
import '../../presentation/auth/register/register_page.dart';
import '../../presentation/auth/reset_password/reset_password_page.dart';
import '../../presentation/filter/filter_page.dart';
import '../../presentation/main/main_page.dart';
import '../../presentation/view_all_product/view_all_products_page.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class AppRouter extends ChangeNotifier {
  // private constructor
  AppRouter._();

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static const String mainName = 'main';
  static const String mainPath = '/';

  static String homeName = "homeName";
  static String homePath = "/homeName";

  static const String registerName = 'register';
  static const String registerPath = '/register';

  static const String loginName = 'login';
  static const String loginPath = '/login';

  static const String forgotPasswordName = 'forgotPassword';
  static const String forgotPasswordPath = '/forgotPassword';

  static const String resetPasswordName = 'resetPassword';
  static const String resetPasswordPath = '/resetPassword';

  static const String viewAllProductsName = 'viewAllProducts';
  static const String viewAllProductsPath = '/viewAllProducts';

  static const String filterName = 'filter';
  static const String filterPath = '/filter';

  static GoRouter get router => _router;
  static final _router = GoRouter(
    redirectLimit: 8,
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: registerPath,
        name: registerName,
        builder: (context, state) {
          return const RegisterPage();
        },
      ),
      GoRoute(
        path: loginPath,
        name: loginName,
        builder: (context, state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        path: forgotPasswordPath,
        name: forgotPasswordName,
        builder: (context, state) {
          return const ForgotPasswordPage();
        },
      ),
      GoRoute(
        path: mainPath,
        name: mainName,
        builder: (context, state) {
          return MainPage(
            tabIndex: (state.uri.queryParameters["tabIndex"] ?? 0) as int,
          );
        },
      ),
      GoRoute(
        path: resetPasswordPath,
        name: resetPasswordName,
        builder: (context, state) {
          return ResetPasswordPage(
            token: state.uri.queryParameters["token"] ?? "",
          );
        },
      ),
      GoRoute(
        path: viewAllProductsPath,
        name: viewAllProductsName,
        builder: (context, state) {
          return ViewAllProductsPage(
            typeProduct: state.extra as TypeProduct? ?? TypeProduct.news,
          );
        },
      ),
      GoRoute(
        path: filterPath,
        name: filterName,
        builder: (context, state) {
          final Map<String, dynamic>? map =
              state.extra as Map<String, dynamic>?;
          final FilterUIModel? filterModel =
              map == null ? null : FilterUIModel.fromMap(map);
          return FilterPage(
            filterUIModel: filterModel,
          );
        },
      ),
    ],
    redirect: (context, state) {
      final userModel = locator<UserModel>();
      final appModel = locator<AppModel>();
      if (userModel.initRoute != null) {
        Future.delayed(
          const Duration(seconds: 1),
          () {
            userModel.updateInitRoute(null);
          },
        );
        return userModel.initRoute;
      }
      return _handleRedirectRouter(
        userModel: userModel,
        appModel: appModel,
        context: context,
        state: state,
      );
    },
    refreshListenable: locator<UserModel>(),
    initialLocation: loginPath,
  );

  static String? _handleRedirectRouter({
    required UserModel userModel,
    required AppModel appModel,
    required BuildContext context,
    required GoRouterState state,
  }) {
    switch (state.uri.path) {
      case "/verify-email":
      case "/forgot-password":
        return _deeplinkNavigation(userModel, appModel, context, state);
      default:
        return _normalNavigation(userModel, appModel, context, state);
    }
  }

  static String? _deeplinkNavigation(
    UserModel userModel,
    AppModel appModel,
    BuildContext context,
    GoRouterState state,
  ) {
    final uri = state.uri;
    switch (uri.path) {
      case "/verify-email":
        return _verifyEmailNavigation(userModel, appModel, context, uri);
      case "/forgot-password":
        return _resetPasswordNavigation(userModel, appModel, context, uri);
      default:
        return state.path;
    }
  }

  static String? _normalNavigation(
    UserModel userModel,
    AppModel appModel,
    BuildContext context,
    GoRouterState state,
  ) {
    if (userModel.isLogin()) {
      if (appModel.router == RouterRedirect.main) {
        appModel.changeRouterRedirect(RouterRedirect.other);
        return mainPath;
      }
      return state.fullPath;
    } else {
      if (appModel.router == RouterRedirect.login) {
        appModel.changeRouterRedirect(RouterRedirect.other);
        return loginPath;
      }
      return state.fullPath;
    }
  }

  static String? _verifyEmailNavigation(
    UserModel userModel,
    AppModel appModel,
    BuildContext context,
    Uri uri,
  ) {
    return loginPath;
  }

  static String? _resetPasswordNavigation(
    UserModel userModel,
    AppModel appModel,
    BuildContext context,
    Uri uri,
  ) {
    return Uri(
      path: resetPasswordPath,
      queryParameters: {
        "token": uri.queryParameters['token'],
      },
    ).toString();
  }
}
