class InfoUserAccessTokenModel {
  UserInfoModel? userInfo;
  String? accessToken;
  String? tokenType;
  int? expiresAt;

  InfoUserAccessTokenModel(
      {this.userInfo, this.accessToken, this.tokenType, this.expiresAt});

  InfoUserAccessTokenModel.fromJson(Map<String, dynamic> json) {
    userInfo = json['user_info'] != null
        ? new UserInfoModel.fromJson(json['user_info'])
        : null;
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresAt = json['expires_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userInfo != null) {
      data['user_info'] = this.userInfo!.toJson();
    }
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_at'] = this.expiresAt;
    return data;
  }
}

class UserInfoModel {
  String? fullName;
  String? email;
  String? avatar;

  UserInfoModel({this.fullName, this.email, this.avatar});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    email = json['email'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['avatar'] = this.avatar;
    return data;
  }
}
