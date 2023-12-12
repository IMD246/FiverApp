import 'package:uuidv6/uuidv6.dart';

class CategoryModel {
  String uid = uuidv6();
  final String category;
  final String urlImages;
  CategoryModel({
    required this.category,
    required this.urlImages,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'category': category,
      'urlImages': urlImages,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      category: map['category'] ?? '',
      urlImages: map['urlImages'] ?? '',
    );
  }
}
