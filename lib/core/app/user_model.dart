import 'package:firebase_core/firebase_core.dart';
import 'package:fiver/core/config/env_config.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../data/model/info_user_access_token.dart';
import '../../domain/repositories/system_repository.dart';
import '../../domain/repositories/user_repository.dart';
import '../../firebase_options.dart';
import '../base/rest_client.dart';
import '../di/locator_service.dart';
import '../enum.dart';
import '../event/user_update_model_event.dart';
import '../utils/crashlytic_util.dart';
import '../utils/dynamic_link_util.dart';
import 'app_model.dart';

class UserModel extends ChangeNotifier {
  late Environment environment;

  final _userRepository = locator<UserRepository>();
  UserInfoModel? userInfo;
  final appModel = locator<AppModel>();
  String? _initRoute;
  String? get initRoute => _initRoute;
  Future<void> init(Environment environment) async {
    this.environment = environment;
    final accessToken = _userRepository.getAccessToken();
    await Future.wait([
      initFirebase(),
      _initAPI(token: accessToken),
    ]);
    await Future.wait([
      initDynamicLink(),
      _userRepository.getMe(isNotifyChange: true),
    ]);
    initFirebaseCrashlytics();
    notifyListeners();
  }

  void updateInitRoute(String? value) {
    _initRoute = value;
  }

  Future<void> _initAPI({String? token}) async {
    EnvConfig.getInstance().init(environment);
    final packageInfo = await PackageInfo.fromPlatform();
    RestClient.instance.init(
      EnvConfig.getInstance().BASEURL ?? "",
      accessToken: token ?? "",
      // platform: Platform.isAndroid ? "android" : "ios",
      appVersion: packageInfo.version,
      // deviceId: await getDeviceId(),
      language: await locator<SystemRepository>().getLanguage(),
    );
  }

  Future<void> initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform(environment),
    );
  }

  bool isLogin() => userInfo != null;

  void onUpdateUserInfo(
      {required UserInfoModel userInfo, bool isNotifyChange = true}) {
    this.userInfo = userInfo;
    if (isNotifyChange) {
      appModel.changeRouterRedirect(
        isLogin() ? RouterRedirect.main : RouterRedirect.login,
      );
      notifyListeners();
    } else {
      eventBus.fire(UserInfoModelUpdateEvent(user: this.userInfo!));
    }
  }

  void logout() async {
    userInfo = null;
    appModel.changeRouterRedirect(RouterRedirect.login);
    notifyListeners();
  }
}
