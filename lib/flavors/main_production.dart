import '../core/config/run_app_config.dart';
import 'package:flutter/material.dart';
import '../core/app/fiver_app.dart';
import '../core/enum.dart';
import '../core/extensions/ext_enum.dart';

void main() async {
  final appConfig = RunAppConfig(
    environment: Environment.prod,
    child: FiverApp(
      titleApp: Environment.prod.getTitle(),
    ),
  );

  await appConfig.init();

  runApp(appConfig.child);
}
