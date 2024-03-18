import '../enum.dart';
import '../res/icons.dart';

extension SocialIconTypeExtension on SocialIconType {
  String getIcon() {
    switch (this) {
      case SocialIconType.google:
        return DIcons.google;
      default:
        throw Exception("Unsupported this $this yet!");
    }
  }
}

extension EnvironmentExtension on Environment {
  String getTitle() {
    switch (this) {
      case Environment.dev:
        return "[DEV]Fiver";
      case Environment.staging:
        return "[STG]Fiver";
      case Environment.prod:
      default:
        return "Fiver";
    }
  }

  String getAppAndroidId() {
    switch (this) {
      case Environment.dev:
        return "1:458951462646:android:0a8f3bcb8aa852b80de6d7";
      case Environment.staging:
        return "1:458951462646:android:f3ba55d7de9f0a9d0de6d7";
      case Environment.prod:
      default:
        return "1:458951462646:android:98f388584a95c6f50de6d7";
    }
  }

  String getAppIOSId() {
    switch (this) {
      case Environment.dev:
        return "1:458951462646:ios:df4569447896f3240de6d7";
      case Environment.staging:
        return "1:458951462646:ios:df4569447896f3240de6d7";
      case Environment.prod:
      default:
        return "1:458951462646:ios:df4569447896f3240de6d7";
    }
  }
}

extension RegisterSocialTypeExtension on RegisterSocialType {
  String getTitle() {
    switch (this) {
      case RegisterSocialType.facebook:
        return "facebook";
      case RegisterSocialType.google:
      default:
        return "google";
    }
  }
}

extension TypeProductExtension on TypeProduct {
  int getValue() {
    switch (this) {
      case TypeProduct.news:
        return 0;
      case TypeProduct.sale:
      default:
        return 1;
    }
  }
}
