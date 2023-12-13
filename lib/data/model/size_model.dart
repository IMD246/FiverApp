import 'dart:convert';

import 'package:isar/isar.dart';

part 'size_model.g.dart';

@Collection()
@Name("sizes")
class SizeModel {
  Id? idLocal;

  final int id;
  @Index(unique: true)
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
