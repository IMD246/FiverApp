import 'package:event_bus/event_bus.dart';
import '../../data/source/local/preferences.dart';
import 'package:flutter/material.dart';

import 'user_model.dart';
import '../res/theme/theme_manager.dart';

import '../di/locator_service.dart';
import '../enum.dart';

class AppModel extends ChangeNotifier {
  late final Environment environment;
  RouterRedirect _routerRedirect = RouterRedirect.login;
  Future<void> init(Environment environment) async {
    this.environment = environment;
    await locator<Preferences>().init();
    locator<ThemeManager>().init();
    await locator<UserModel>().init(environment);
  }

  changeRouterRedirect(RouterRedirect redirect) {
    _routerRedirect = redirect;
  }

  RouterRedirect get router => _routerRedirect;
}

EventBus eventBus = EventBus();
