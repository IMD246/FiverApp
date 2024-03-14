class UserInfoModel {
  String? fullName;
  String? email;
  String? avatar;
  String? dateOfBirth;

  UserInfoModel({this.fullName, this.email, this.avatar, this.dateOfBirth});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    email = json['email'];
    avatar = json['avatar'];
    dateOfBirth = json['date_of_birth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['full_name'] = fullName;
    data['email'] = email;
    data['avatar'] = avatar;
    data['date_of_birth'] = dateOfBirth;
    return data;
  }
}