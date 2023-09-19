import 'package:fiven/base/rest_client.dart';

abstract class BaseSerivce {
  late RestClient restClient;
  BaseSerivce(RestClient rest) {
    restClient = rest;
  }
}
