import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:device_info_plus/device_info_plus.dart';
import '../extensions/ext_localization.dart';
import '../res/colors.dart';
import '../res/theme/text_theme.dart';
import '../res/theme/theme_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'navigation_service.dart';

class PermissionHandlerUtil {
  static Future<bool> checkAndRequestPermission(Permission permission) async {
    try {
      PermissionStatus status = await permission.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  static Future<bool> checkAndRequestPermissionPhoto() async {
    late bool isAllow;
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt <= 32) {
        isAllow = await checkAndRequestPermission(Permission.storage);
      } else {
        isAllow = await checkAndRequestPermission(Permission.photos);
      }
    }
    if (!isAllow) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        NavigationService.scaffoldKey.currentState!.showSnackBar(
          _showSnackbar(
            content: NavigationService.currentContext!.loc.permission_message(
                NavigationService.currentContext!.loc.gallery),
            onPressed: () {
              AppSettings.openAppSettings(type: AppSettingsType.settings);
            },
          ),
        );
      });
      return false;
    }
    return true;
  }

  static Future<bool> checkAndRequestPermissionCamera() async {
    bool isAllow = await checkAndRequestPermission(Permission.camera);
    if (!isAllow) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        NavigationService.scaffoldKey.currentState!.showSnackBar(
          _showSnackbar(
            content: NavigationService.currentContext!.loc.permission_message(
                NavigationService.currentContext!.loc.camera),
            onPressed: () {
              AppSettings.openAppSettings(type: AppSettingsType.settings);
            },
          ),
        );
      });
      return false;
    }
    return true;
  }

  static SnackBar _showSnackbar({
    int? milliseconds,
    required String content,
    String? labelAction,
    void Function()? onPressed,
  }) {
    NavigationService.scaffoldKey.currentState!.hideCurrentSnackBar();
    return SnackBar(
      backgroundColor: getColor().themeColorPrimary,
      behavior: SnackBarBehavior.floating,
      duration: Duration(
        milliseconds: milliseconds ?? 2000,
      ),
      content: Text(
        content,
        style: text12.copyWith(
          color: getColor().themeColor222222White,
        ),
      ),
      action: SnackBarAction(
        label: labelAction ?? NavigationService.currentContext!.loc.to_settings,
        textColor: colorWhite,
        backgroundColor: Colors.red,
        onPressed: onPressed ?? () {},
      ),
    );
  }
}
