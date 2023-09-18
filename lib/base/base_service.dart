import 'package:fiven/base/rest_client.dart';

import '../di/locator_service.dart';

abstract class BaseSerivce {
  final RestClient _restClient = locator<RestClient>();
  Future<dynamic> get() async {}
}
