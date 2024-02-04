// ignore_for_file: non_constant_identifier_names
import 'package:fiver/core/enum.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  String? BASEURL;

  EnvConfig._();

  static EnvConfig? _instance;

  static EnvConfig getInstance() {
    _instance ??= EnvConfig._();
    return _instance!;
  }

  Future<void> init(Environment environment) async {
    switch (environment) {
      case Environment.dev:
        await dotenv.load(fileName: "assets/env/.env.dev");
        break;
      case Environment.prod:
        await dotenv.load(fileName: "assets/env/.env.prod");
        break;
      case Environment.staging:
        await dotenv.load(fileName: "assets/env/.env.staging");
        break;
    }
    BASEURL = dotenv.get("BASE_URL");
  }
}
