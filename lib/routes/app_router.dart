import 'package:fiven/di/locator_service.dart';
import 'package:fiven/domain/viewModel/user_model.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  // private constructor
  AppRouter._();

  static const String mainNamed = 'main';
  static const String mainPath = '/';

  static String homeName = "homeName";
  static String homePath = "/homeName";

  static GoRouter get router => _router;
  static final _router = GoRouter(
    redirectLimit: 8,
    routes: [
      // GoRoute(
      //   path: homePath,
      //   name: homeName,
      //   builder: (context, state) {
      //     // return HomePage();
      //   },
      // )
    ],
    redirect: (context, state) {
      // handle redirect when userModel changes
      final userModel = locator<UserModel>();
    },
    refreshListenable: locator<UserModel>(),
    initialLocation: mainPath,
  );
}
