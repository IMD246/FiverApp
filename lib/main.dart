import 'package:fiven/app/app_config.dart';
import 'package:fiven/constant/enum.dart';
import 'package:fiven/domain/viewModel/app_model.dart';
import 'package:fiven/di/locator_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app/fiven_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initLocatorSerivce();
  await initAppModel();
  setupStatusBar();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const FivenApp()));
}

Future<void> initAppModel() async {
  await locator<AppModel>().init(Environment.dev);
}
