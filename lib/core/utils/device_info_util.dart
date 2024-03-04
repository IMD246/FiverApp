import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

Future<String> getDeviceId() async {
  final deviceInfoPlugin = DeviceInfoPlugin();
  try {
    if (Platform.isAndroid) {
      final build = await deviceInfoPlugin.androidInfo;
      return build.id;
    } else if (Platform.isIOS) {
      final data = await deviceInfoPlugin.iosInfo;
      return data.identifierForVendor ?? ""; //UUID for iOS
    }
  } on PlatformException {
    if (kDebugMode) {
      print('Failed to get platform version');
    }
  }
  return "";
}

String getDeviceOS() {
  return Platform.isAndroid ? "Android" : "Ios";
}
