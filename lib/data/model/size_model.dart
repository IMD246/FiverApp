import 'dart:convert';

class SizeModel {
  final String sizeName;
  SizeModel({
    required this.sizeName,
  });

  Map<String, dynamic> toMap() {
    return {
      'sizeName': sizeName,
    };
  }

  factory SizeModel.fromMap(Map<String, dynamic> map) {
    return SizeModel(
      sizeName: map['sizeName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SizeModel.fromJson(String source) =>
      SizeModel.fromMap(json.decode(source));
}
