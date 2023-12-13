import 'dart:convert';

class CategoryModel {
  final int id;
  final String category;
  final String urlImages;

  CategoryModel(
      {required this.id, required this.category, required this.urlImages});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'urlImages': urlImages,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id']?.toInt() ?? 0,
      category: map['category'] ?? '',
      urlImages: map['urlImages'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source));
}
