import 'package:fiver/core/di/locator_service.dart';
import 'package:fiver/domain/provider/user_model.dart';
import 'package:fiver/presentation/auth/forgot_password/forgot_password_page.dart';
import 'package:fiver/presentation/auth/login/login_page.dart';
import 'package:fiver/presentation/auth/register/register_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  // private constructor
  AppRouter._();

  static const String mainNamed = 'main';
  static const String mainPath = '/';

  static String homeName = "homeName";
  static String homePath = "/homeName";

  static const String registerName = 'register';
  static const String registerPath = '/register';

  static const String loginName = 'login';
  static const String loginPath = '/login';

  static const String forgotPasswordName = 'forgotPassword';
  static const String forgotPasswordPath = '/forgotPassword';

  static GoRouter get router => _router;
  static final _router = GoRouter(
    redirectLimit: 8,
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
    ],
    redirect: (context, state) {
      // handle redirect when userModel changes
      final userModel = locator<UserModel>();
    },
    refreshListenable: locator<UserModel>(),
    initialLocation: loginPath,
  );
}
