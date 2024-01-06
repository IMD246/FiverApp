import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:fiver/core/enum.dart';
import 'package:flutter/foundation.dart';
import '../app/user_model.dart';
import '../di/locator_service.dart';
import '../routes/app_router.dart';

Future<void> initDynamicLink() async {
  final firebaseDynamicLink = FirebaseDynamicLinks.instance;

  // init link
  final PendingDynamicLinkData? initialLink =
      await firebaseDynamicLink.getInitialLink();
  _handleDynamicLinks(dynamicLinkData: initialLink);

  // listen link
  firebaseDynamicLink.onLink.listen((dynamicLinkData) {
    log("show link: ${dynamicLinkData.link}");
  }).onError((error) {
    // Handle errors
    // ignore: prefer_interpolation_to_compose_strings
    log(name: "dynamicLink", "error: " + error.message);
  });
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
      Uri(path: AppRouter.resetPasswordPath, queryParameters: {
        "token": link.queryParameters["token"],
      }).toString(),
    );
  }

  if (link.path == "/product-detail") {
    locator<UserModel>().updateInitRoute(
      Uri(
        path: AppRouter.productDetailPath,
        queryParameters: {
          "id": link.queryParameters["id"],
          "name": link.queryParameters["name"],
        },
      ).toString(),
    );
  }
}

Future<Uri?> createDynamicLink({
  String? path,
  Map<String, dynamic>? queryParameters,
}) async {
  try {
    const baseUrlPrefix = "https://examplefiver2.page.link";
    String packageName = "com.example.fiver";
    final userModel = locator<UserModel>();
    if (userModel.environment != Environment.prod) {
      packageName += ".dev";
    }
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: baseUrlPrefix,
      link: Uri(
          host: "examplefiver2.page.link",
          scheme: "https",
          path: path,
          queryParameters: queryParameters),
      androidParameters: AndroidParameters(
        packageName: packageName,
        minimumVersion: 0,
      ),
      iosParameters: IOSParameters(
        bundleId: packageName,
        minimumVersion: '0',
      ),
    );

    Uri url;

    final ShortDynamicLink shortLink =
        await FirebaseDynamicLinks.instance.buildShortLink(
      parameters,
      shortLinkType: ShortDynamicLinkType.short,
    );
    url = shortLink.shortUrl;

    return url;
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    return null;
  }
}
