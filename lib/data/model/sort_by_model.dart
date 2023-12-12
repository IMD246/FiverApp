import 'dart:convert';

import 'package:uuidv6/uuidv6.dart';

class SortByModel {
  String uid = uuidv6();
  String name;
  SortByModel({
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  factory SortByModel.fromMap(Map<String, dynamic> map) {
    return SortByModel(
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SortByModel.fromJson(String source) => SortByModel.fromMap(json.decode(source));
}
