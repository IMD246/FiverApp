import 'dart:convert';

class MBrand {
  final int id;
  final String name;

  MBrand({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory MBrand.fromMap(Map<String, dynamic> map) {
    return MBrand(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MBrand.fromJson(String source) => MBrand.fromMap(json.decode(source));
}
