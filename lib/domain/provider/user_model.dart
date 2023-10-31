import 'package:fiven/base/rest_client.dart';
import 'package:fiven/core/enum.dart';
import 'package:fiven/core/di/locator_service.dart';
import 'package:flutter/material.dart';

import '../../data/remote/network/network_url.dart';

class UserModel extends ChangeNotifier {
  late Environment environment;
  String? accessToken;
  Future<void> init(Environment environment) async {
    this.environment = environment;
    await _initAPI(token: accessToken);
    notifyListeners();
  }

  Future<void> _initAPI({String? token}) async {
    String baseUrl;

    switch (environment) {
      case Environment.dev:
      default:
        baseUrl = baseURL;
    }

    await locator<RestClient>().init(baseUrl, token: token);
  }
}
