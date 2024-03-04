import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../data/model/notification_item.dart';
import '../di/locator_service.dart';
import '../helper/local_notification_helper.dart';
import 'user_model.dart';

class PushNotificationManager {
  LocalNotificationHelper? localNotificationHelper;

  Future<void> init() async {
    // Setup permission to Firebase Messaging
    FirebaseMessaging.instance.requestPermission();

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    localNotificationHelper = LocalNotificationHelper();
    _onReceiveMessage();
    await localNotificationHelper?.init();
  }

  void _onReceiveMessage() async {
    // Refresh token Firebase Messaging
    FirebaseMessaging.instance.onTokenRefresh.listen((token) async {
      await locator<UserModel>().updateFirebaseToken(token: token);
    });

    // In case the app on the terminated state and first initializes
    FirebaseMessaging.instance.getInitialMessage().then(
      (RemoteMessage? message) {
        if (message != null) {
          Future.delayed(
            const Duration(seconds: 3),
            () {
              EasyLoading.showSuccess(
                "Firebase initial",
                duration: const Duration(seconds: 3),
              );
            },
          );
          var data = _getNotificationData(message.data);
          log("Firebase initial: ${data?.id}");
          // if (data != null) {
          //   Future.delayed(const Duration(seconds: 1), () {
          //     handleNotification(data);
          //   });
          // }
        }
      },
    );

    // In case the app in foreground mode
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      try {
        var notification = _getNotification(message);
        var data = _getNotificationData(message.data);
        log("Firebase onMessage: ${data?.id ?? ""}");
        if (notification != null && notification.android != null) {
          await localNotificationHelper?.showNotification(
            notification.title,
            notification.body,
            payload: message.data['payload'] ?? "",
          );
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    });

    // In case the app still be running the background mode but not terminated
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      var data = _getNotificationData(message.data);
      log("Firebase onMessageOpenedApp: ${data?.id}");
      // if (data != null) {
      //   Future.delayed(const Duration(seconds: 1), () {
      //     handleNotification(data);
      //   });
      // }
    });

    // Get APNS IOS
    if (Platform.isIOS) {
      String? aspnToken = await FirebaseMessaging.instance.getAPNSToken();
      log('FlutterFire Messaging Example: Got APNs token: $aspnToken');
    }

    // Get token device
    String? token = await FirebaseMessaging.instance.getToken();

    // update token device to server
    if (token != null) {
      locator<UserModel>().updateFirebaseToken(token: token);
    }
  }

  void handleBackgroundNotification(RemoteMessage message) {
    var data = _getNotificationData(message.data);
    log("Firebase background: ${data?.id}");
    if (data != null) {
      // Future.delayed(const Duration(seconds: 1), () {
      //   handleNotification(data);
      // });
    }
  }

  RemoteNotification? _getNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    return notification;
  }

  NotificationItem? _getNotificationData(Map<String, dynamic> jsonData) {
    try {
      NotificationItem data;
      data = NotificationItem.fromJson(jsonData);
      return data;
    } catch (error) {
      if (kDebugMode) {
        print("ICOGENDUSER_JSON_ERROR: $error ");
      }
      return null;
    }
  }
}
