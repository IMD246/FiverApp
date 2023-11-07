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
