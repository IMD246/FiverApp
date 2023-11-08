import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:fiver/core/routes/app_router.dart';

void initDynamicLink() {
  FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
    _handleDynamicLinks(isInit: false, dynamicLinkData: dynamicLinkData);
  }).onError((error) {
    // Handle errors
    log(name: "dynamicLink", "error: " + error.message);
  });
}

Future<String?> getInitPath() async {
  // Get any initial links
  final PendingDynamicLinkData? initialLink =
      await FirebaseDynamicLinks.instance.getInitialLink();
  return _handleDynamicLinks(dynamicLinkData: initialLink);
}

String? _handleDynamicLinks(
    {bool isInit = true, PendingDynamicLinkData? dynamicLinkData}) {
  final param = dynamicLinkData?.link.queryParameters;
  log("link:" + (dynamicLinkData?.link.host ?? ""));
  log("path dynamic:" + (dynamicLinkData?.link.path ?? ""));
  final getScreen = param?["screen"];
  if (getScreen != null && !isInit) {
    AppRouter.router.push(getScreen);
  }
  // if(param["screen"] == "/forgotPassword")
  return getScreen;
}
