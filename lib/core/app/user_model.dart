import 'package:firebase_core/firebase_core.dart';
import 'package:fiver/data/data_source/local/preferences.dart';
import '../config/env_config.dart';
import '../utils/collection_util.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../data/model/info_user_access_token.dart';
import '../../domain/repositories/system_repository.dart';
import '../../domain/repositories/user_repository.dart';
import '../utils/firebase_utils.dart';
import '../base/rest_client.dart';
import '../di/locator_service.dart';
import '../enum.dart';
import '../event/user_update_model_event.dart';
import '../utils/crashlytic_util.dart';
import '../utils/device_info_util.dart';
import '../utils/dynamic_link_util.dart';
import 'app_model.dart';
import 'push_notification_manager.dart';

class UserModel extends ChangeNotifier {
  late Environment environment;

  final _userRepository = locator<UserRepository>();
  final _pref = locator<Preferences>();

  UserInfoModel? userInfo;

  final appModel = locator<AppModel>();

  String? _initRoute;

  String? accessToken;

  String? get initRoute => _initRoute;

  Future<void> init(Environment environment) async {
    this.environment = environment;
    final accessToken = _userRepository.getAccessToken();
    this.accessToken = accessToken;
    await Future.wait([
      initFirebase(),
      _initAPI(token: accessToken),
    ]);

    await Future.wait([
      initDynamicLink(),
    ]);
    initFirebaseCrashlytics();
    if (!accessToken.isNullOrEmpty) {
      final user = _pref.getUser();
      if (user != null) {
        onUpdateUserInfo(userInfo: user);
      }
    }
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
      platform: getDeviceOS(),
      appVersion: packageInfo.version,
      deviceId: await getDeviceId(),
      language: await locator<SystemRepository>().getLanguage(),
    );

    locator<PushNotificationManager>().init();
  }

  Future<void> initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  bool isLogin() => userInfo != null && !accessToken.isNullOrEmpty;

  void onUpdateUserInfo({
    required UserInfoModel userInfo,
    bool isNotifyChange = true,
  }) {
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

  Future<void> updateFirebaseToken({String? token}) async {
    debugPrint(
        '-------------------DeviceToken: $token --------------------------');
    if (token != null) {
      await _userRepository.updateDeviceToken(deviceToken: token);
      if (isLogin()) {
        await _userRepository.registerDeviceToken(deviceToken: token);
      }
    }
  }

  void logout() async {
    userInfo = null;
    accessToken = null;
    appModel.changeRouterRedirect(RouterRedirect.login);
    notifyListeners();
  }
}
