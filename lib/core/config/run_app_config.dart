import 'package:firebase_messaging/firebase_messaging.dart';
import '../enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../app/app_config.dart';
import '../app/app_model.dart';
import '../app/push_notification_manager.dart';
import '../di/locator_service.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await initLocatorSerivce();
  locator<PushNotificationManager>().handleBackgroundNotification(message);
}

class RunAppConfig {
  final Widget child;
  final Environment environment;
  const RunAppConfig({
    required this.child,
    required this.environment,
  });

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    initLocatorSerivce();
    setupStatusBar();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await Future.wait(
      [
        _initAppModel(),
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]),
      ],
    );
  }

  Future<void> _initAppModel() async {
    await locator<AppModel>().init(environment);
  }
}
