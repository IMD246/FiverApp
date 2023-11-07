import 'package:firebase_core/firebase_core.dart';
import 'package:fiver/core/base/rest_client.dart';
import 'package:fiver/core/enum.dart';
import 'package:fiver/core/di/locator_service.dart';
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
  Future<void> init(Environment environment) async {
    this.environment = environment;
    accessToken = await _userRepository.getAccessToken();
    await initFirebase();
    initFirebaseCrashlytics();
    await _initAPI(token: accessToken);
    notifyListeners();
  }

  Future<void> _initAPI({String? token}) async {
    String baseUrl;
    switch (environment) {
      case Environment.dev:
        baseUrl = baseURLDEV;
      case Environment.staging:
        baseUrl = baseURLDEV;
      case Environment.prod:
      default:
        baseUrl = baseURLPROD;
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
}
