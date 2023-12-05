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

  ValidatorModel({
    required this.email,
    required this.password,
    required this.fullName,
  });

  ValidatorModel.fromMap(Map<String, dynamic> map) {
    email = List<String>.from(map['email'] ?? []);
    password = List<String>.from(map['password'] ?? []);
    fullName = List<String>.from(map['full_name'] ?? []);
  }
}
