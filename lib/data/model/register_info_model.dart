class RegisterInfoModel {
  final String name;
  final String email;
  final String password;
  String? userUrl;
  RegisterInfoModel({
    required this.name,
    required this.email,
    required this.password,
    this.userUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'userUrl': userUrl,
    };
  }
}
