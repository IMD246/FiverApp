class ApiException implements Exception {
  final int code;
  final String message;
  final ValidatorModel? validator;
  ApiException({this.validator, required this.code, required this.message});

  factory ApiException.fromMap(Map<String, dynamic> map, int code) {
    return ApiException(
      code: code,
      message: map['message'] ?? '',
      validator: map['validator'] != null
          ? ValidatorModel.fromMap(map['validator'])
          : null,
    );
  }
}

class ValidatorModel {
  List<String> email = [];
  List<String> password = [];
  List<String> fullName = [];
  String oldPassword = "";
  List<String> dateOfBirth = [];

  ValidatorModel({
    required this.email,
    required this.password,
    required this.fullName,
    required this.oldPassword,
    required this.dateOfBirth,
  });

  ValidatorModel.fromMap(Map<String, dynamic> map) {
    email = List<String>.from(map['email'] ?? []);
    password = List<String>.from(map['password'] ?? []);
    fullName = List<String>.from(map['full_name'] ?? []);
    oldPassword = map['old_password'] ?? "";
    dateOfBirth = List<String>.from(map['date_of_birth'] ?? []);
  }
}
