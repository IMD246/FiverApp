import 'package:fiver/core/constant/date_time_constants.dart';
import 'package:fiver/core/extensions/ext_datetime.dart';

class UserInfoModel {
  String? fullName;
  String? email;
  String? avatar;
  DateTime? dateOfBirth;

  UserInfoModel({this.fullName, this.email, this.avatar, this.dateOfBirth});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    email = json['email'];
    avatar = json['avatar'];
    if (json['date_of_birth'] != null) {
      dateOfBirth = DateTime.tryParse(json['date_of_birth']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['full_name'] = fullName;
    data['email'] = email;
    data['avatar'] = avatar;
    if (dateOfBirth != null) {
      data['date_of_birth'] = dateOfBirth!.formatToDateString(type: DateTimeConstants.DATE_FORMAT);
    }
    return data;
  }
}