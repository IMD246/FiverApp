class GenderModel {
  final String gender;
  GenderModel({
    required this.gender,
  });

  Map<String, dynamic> toMap() {
    return {
      'gender': gender,
    };
  }

  factory GenderModel.fromMap(Map<String, dynamic> map) {
    return GenderModel(
      gender: map['gender'] ?? '',
    );
  }
}
