import 'package:firebase_core/firebase_core.dart';
import 'package:fiver/core/base/rest_client.dart';
import 'package:fiver/core/enum.dart';
import 'package:fiver/core/di/locator_service.dart';
import 'package:fiver/core/event/user_update_model_event.dart';
import 'package:fiver/core/utils/util.dart';
import 'package:fiver/data/model/info_user_access_token.dart';
import 'package:fiver/domain/provider/app_model.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../core/utils/crashlytic_util.dart';
import '../../data/remote/network/network_url.dart';
import '../../firebase_options.dart';
import '../repositories/system_repository.dart';
import '../repositories/user_repository.dart';

class UserModel extends ChangeNotifier {
  late Environment environment;
  String? accessToken;
  final _userRepository = locator<UserRepository>();
  UserInfoModel? userInfo;
  final appModel = locator<AppModel>();
  Future<void> init(Environment environment) async {
    this.environment = environment;
    accessToken = _userRepository.getAccessToken();
    await Future.wait([initFirebase(), _initAPI(token: accessToken)]);
    await _userRepository.getMe(isNotifyChange: true);
    initFirebaseCrashlytics();
    notifyListeners();
  }

  Future<void> _initAPI({String? token}) async {
    String baseUrl;
    switch (environment) {
      case Environment.staging:
        baseUrl = baseURLSTG;
      case Environment.prod:
        baseUrl = baseURLPROD;
      case Environment.dev:
      default:
        baseUrl = baseURLDEV;
    }
    final packageInfo = await PackageInfo.fromPlatform();
    RestClient.instance.init(
      baseUrl,
      accessToken: token ?? "",
      // platform: Platform.isAndroid ? "android" : "ios",
      appVersion: packageInfo.version,
      // deviceId: await getDeviceId(),
      language: await locator<SystemRepository>().getLanguage(),
    );
  }

  Future<void> initFirebase() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }

  bool get isLogin => userInfo != null && !accessToken.isNullOrEmpty;

  void onUpdateUserInfo(
      {required UserInfoModel userInfo, bool isNotifyChange = true}) {
    this.userInfo = userInfo;
    if (isNotifyChange) {
      appModel.changeRouterRedirect(
        isLogin ? RouterRedirect.main : RouterRedirect.login,
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
