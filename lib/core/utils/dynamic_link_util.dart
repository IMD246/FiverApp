import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:fiver/core/di/locator_service.dart';
import 'package:fiver/core/routes/app_router.dart';
import 'package:fiver/domain/provider/user_model.dart';

Future<void> initDynamicLink() async {
  final firebaseDynamicLink = FirebaseDynamicLinks.instance;

  // init link
  final PendingDynamicLinkData? initialLink =
      await firebaseDynamicLink.getInitialLink();
  _handleDynamicLinks(dynamicLinkData: initialLink);

  // listen link
  firebaseDynamicLink.onLink.listen((dynamicLinkData) {
    _handleDynamicLinks(isInit: false, dynamicLinkData: dynamicLinkData);
  }).onError((error) {
    // Handle errors
    log(name: "dynamicLink", "error: " + error.message);
  });
}

String? _handleDynamicLinks(
    {bool isInit = true, PendingDynamicLinkData? dynamicLinkData}) {
  final link = dynamicLinkData?.link;
  final screen = link?.queryParameters["screen"];
  log("link listen:" + (link?.host ?? ""));
  log("path dynamic listen:" + (link?.path ?? ""));
  log("screen listen:" + (link?.queryParameters["screen"] ?? ""));
  if (link?.path.contains("/change-password") == true) {
    locator<UserModel>().updateInitRoute(AppRouter.registerPath);
  }
  return null;
}
