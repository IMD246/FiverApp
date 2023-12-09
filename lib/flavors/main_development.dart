import 'package:fiver/core/app/app_config.dart';
import 'package:fiver/core/enum.dart';
import 'package:fiver/core/extensions/ext_enum.dart';
import 'package:fiver/core/app/app_model.dart';
import 'package:fiver/core/di/locator_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/app/fiver_app.dart';

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
