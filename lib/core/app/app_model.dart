import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';

import '../../data/data_source/local/isar_db.dart';
import '../../data/data_source/local/preferences.dart';
import '../di/locator_service.dart';
import '../enum.dart';
import '../res/theme/theme_manager.dart';
import 'user_model.dart';

class AppModel extends ChangeNotifier {
  late final Environment environment;
  RouterRedirect _routerRedirect = RouterRedirect.login;
  Future<void> init(Environment environment) async {
    this.environment = environment;
    await Future.wait(
      [
        locator<IsarDb>().init(),
        locator<Preferences>().init(),
      ],
    );
    locator<ThemeManager>().init();
    await locator<UserModel>().init(environment);
  }

  void changeRouterRedirect(RouterRedirect redirect) {
    _routerRedirect = redirect;
  }

  RouterRedirect get router => _routerRedirect;
}

EventBus eventBus = EventBus();
