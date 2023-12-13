import 'dart:convert';

import 'package:isar/isar.dart';

part 'sort_by_model.g.dart';

@Collection()
@Name("sortBy")
class SortByModel {
  Id? idLocal;

  final int id;
  final String name;
  SortByModel({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory SortByModel.fromMap(Map<String, dynamic> map) {
    return SortByModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SortByModel.fromJson(String source) =>
      SortByModel.fromMap(json.decode(source));
}
