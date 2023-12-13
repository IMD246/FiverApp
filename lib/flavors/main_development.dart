import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/app/app_config.dart';
import '../core/app/app_model.dart';
import '../core/app/fiver_app.dart';
import '../core/di/locator_service.dart';
import '../core/enum.dart';
import '../core/extensions/ext_enum.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initLocatorSerivce();
  setupStatusBar();
  await initAppModel();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(FiverApp(titleApp: Environment.dev.getTitle())));
}

Future<void> initAppModel() async {
  await locator<AppModel>().init(Environment.dev);
}
