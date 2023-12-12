import 'dart:convert';

import 'package:uuidv6/uuidv6.dart';

class BrandModel {
  final String uid = uuidv6();
  final String name;
  BrandModel({
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  factory BrandModel.fromMap(Map<String, dynamic> map) {
    return BrandModel(
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory BrandModel.fromJson(String source) =>
      BrandModel.fromMap(json.decode(source));
}
