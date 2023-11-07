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
        return "[DEV]Fiver ";
      case Environment.staging:
        return "[STG]Fiver";
      case Environment.prod:
      default:
        return "Fiver";
    }
  }
}
