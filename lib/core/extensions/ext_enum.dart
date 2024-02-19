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

  String getAndroidAppId() {
    switch (this) {
      case Environment.dev:
        return "1:458951462646:android:d0be5948a16e0a220de6d7";
      case Environment.staging:
        return "1:458951462646:android:e2ccceecf092ca510de6d7";
      case Environment.prod:
      default:
        return "1:458951462646:android:71aacd9d168dce5e0de6d7";
    }
  }

  String getIOSAppId() {
    switch (this) {
      case Environment.dev:
        return "1:458951462646:ios:640d291a084d0cd60de6d7";
      case Environment.staging:
        return "1:458951462646:ios:640d291a084d0cd60de6d7";
      case Environment.prod:
      default:
        return "1:458951462646:ios:640d291a084d0cd60de6d7";
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
