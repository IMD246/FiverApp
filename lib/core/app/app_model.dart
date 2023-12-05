import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';

import 'package:fiver/core/app/user_model.dart';
import 'package:fiver/core/res/theme/theme_manager.dart';

import '../di/locator_service.dart';
import '../enum.dart';

class AppModel extends ChangeNotifier {
  late final Environment environment;
  RouterRedirect _routerRedirect = RouterRedirect.login;
  Future<void> init(Environment environment) async {
    this.environment = environment;
    await locator<ThemeManager>().init();
    await locator<UserModel>().init(environment);
  }

  changeRouterRedirect(RouterRedirect redirect) {
    _routerRedirect = redirect;
  }

  RouterRedirect get router => _routerRedirect;
}

EventBus eventBus = EventBus();
