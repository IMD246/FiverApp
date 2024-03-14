import 'user_info_model.dart';

class InfoUserAccessTokenModel {
  UserInfoModel? userInfo;
  String? accessToken;
  String? tokenType;
  int? expiresAt;

  InfoUserAccessTokenModel(
      {this.userInfo, this.accessToken, this.tokenType, this.expiresAt});

  InfoUserAccessTokenModel.fromJson(Map<String, dynamic> json) {
    userInfo = json['user_info'] != null
        ? UserInfoModel.fromJson(json['user_info'])
        : null;
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresAt = json['expires_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userInfo != null) {
      data['user_info'] = userInfo!.toJson();
    }
    data['access_token'] = accessToken;
    data['token_type'] = tokenType;
    data['expires_at'] = expiresAt;
    return data;
  }
}