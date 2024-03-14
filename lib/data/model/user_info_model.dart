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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['full_name'] = fullName;
    data['email'] = email;
    data['avatar'] = avatar;
    return data;
  }
}