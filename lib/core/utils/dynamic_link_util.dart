// import 'dart:developer';
// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:fiver/core/routes/app_router.dart';

// Future<void> initDynamicLink() async {
//   final firebaseDynamicLink = FirebaseDynamicLinks.instance;

//   // init link
//   final PendingDynamicLinkData? initialLink =
//       await firebaseDynamicLink.getInitialLink();
//   _handleDynamicLinks(dynamicLinkData: initialLink);

//   // listen link
//   firebaseDynamicLink.onLink.listen((dynamicLinkData) {
//     _handleDynamicLinks(isInit: false, dynamicLinkData: dynamicLinkData);
//   }).onError((error) {
//     // Handle errors
//     log(name: "dynamicLink", "error: " + error.message);
//   });
// }

// void _handleDynamicLinks({
//   bool isInit = true,
//   PendingDynamicLinkData? dynamicLinkData,
// }) {
//   if (!isInit) {
//     if (dynamicLinkData?.link.path == "/verify-email") {
//       AppRouter.router.push(AppRouter.loginPath);
//     }
//   }
// }
