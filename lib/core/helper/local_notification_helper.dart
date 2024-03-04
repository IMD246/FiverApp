import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../data/model/notification_item.dart';

class LocalNotificationHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  int fcmId = 0;

  Future<void> init() async {
    _requestPermissions();

    // Init Settings Android Notification
    const initializationSettingsAndroid = AndroidInitializationSettings(
      'ic_notification',
    );

    // Init Settings IOS Notification
    final initializationSettingsDarwin = DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    // Init platform settings notification for flutter local notification
    await flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin,
      ),
      onDidReceiveNotificationResponse: (notificationResponse) {
        if (notificationResponse.payload != null) {
          // var data =
          // _getNotificationData(notificationResponse.payload .toString());
          // if (data != null) {
          //   Future.delayed(const Duration(seconds: 1), () {
          //     handleNotification(data);
          //   });
          // }
        }
      },
    );
  }

  void _requestPermissions() {
    // Request permission Android notification plugin
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    // Request permission IOS notification plugin
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> showNotification(
    String? title,
    String? body, {
    String? payload,
  }) async {
    // Config Notification details's android
    const androidNotificationDetails = AndroidNotificationDetails(
      "notification_fiver",
      "Icon HRM",
      importance: Importance.high,
      playSound: true,
      priority: Priority.high,
      autoCancel: true,
      icon: 'ic_notification',
      channelAction: AndroidNotificationChannelAction.createIfNotExists,
    );

    NotificationDetails platformChannelSpecifics = const NotificationDetails(
      android: androidNotificationDetails,
    );

    // Execute action push local notification
    await flutterLocalNotificationsPlugin.show(
      fcmId++,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  void onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) {
    if (kDebugMode) {
      print(
        "onDidReceiveLocal: ${payload ?? ""}",
      );
    }
  }

  NotificationItem? _getNotificationData(Map<String, dynamic> jsonData) {
    try {
      NotificationItem data;
      data = NotificationItem.fromJson(jsonData);
      return data;
    } catch (error) {
      if (kDebugMode) {
        print("INVEST_JSON_ERROR: $error ");
      }
      return null;
    }
  }
}
