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

  // // listen link
  // firebaseDynamicLink.onLink.listen((dynamicLinkData) {
  //   _handleDynamicLinks(isInit: false, dynamicLinkData: dynamicLinkData);
  // }).onError((error) {
  //   // Handle errors
  //   log(name: "dynamicLink", "error: " + error.message);
  // });
}

void _handleDynamicLinks({
  PendingDynamicLinkData? dynamicLinkData,
}) {
  final link = dynamicLinkData?.link;
  if (link == null) {
    return;
  }
  if (link.path == "/forgot-password") {
    locator<UserModel>().updateInitRoute(
      Uri(
          path: AppRouter.resetPasswordPath,
          queryParameters: {"token": link.queryParameters["token"]}).toString(),
    );
  }
}
