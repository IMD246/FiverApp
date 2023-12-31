import 'dart:convert';

import 'package:isar/isar.dart';

part 'gender_model.g.dart';

@collection
@Name('genders')
class GenderModel {
  Id? idLocal;

  final int id;
  final String gender;
  GenderModel({
    required this.id,
    required this.gender,
  });

 

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'gender': gender,
    };
  }

  factory GenderModel.fromMap(Map<String, dynamic> map) {
    return GenderModel(
      id: map['id']?.toInt() ?? 0,
      gender: map['gender'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory GenderModel.fromJson(String source) => GenderModel.fromMap(json.decode(source));
}
