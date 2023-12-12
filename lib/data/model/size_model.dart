import 'dart:convert';

class SizeModel {
  final int id;
  final String sizeName;
  SizeModel({
    required this.id,
    required this.sizeName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sizeName': sizeName,
    };
  }

  factory SizeModel.fromMap(Map<String, dynamic> map) {
    return SizeModel(
      id: map['id']?.toInt() ?? 0,
      sizeName: map['sizeName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SizeModel.fromJson(String source) =>
      SizeModel.fromMap(json.decode(source));
}
