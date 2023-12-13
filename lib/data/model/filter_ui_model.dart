import 'dart:convert';
import 'dart:ui';

import 'brand_model.dart';
import 'category_model.dart';

class FilterUIModel {
  final double minPrice;
  final double maxPrice;
  final List<Color> colors;
  final List<int> sizes;
  final CategoryModel? category;
  final List<BrandModel> brands;
  FilterUIModel({
    required this.minPrice,
    required this.maxPrice,
    required this.colors,
    required this.sizes,
    this.category,
    required this.brands,
  });

  Map<String, dynamic> toMap() {
    return {
      'minPrice': minPrice,
      'maxPrice': maxPrice,
      'colors': colors,
      'sizes': sizes,
      'category': category,
      'brands': brands,
    };
  }

  factory FilterUIModel.fromMap(Map<String, dynamic> map) {
    return FilterUIModel(
      minPrice: map['minPrice']?.toDouble() ?? 0.0,
      maxPrice: map['maxPrice']?.toDouble() ?? 0.0,
      colors: map['colors'] ?? <Color>[],
      sizes: map['sizes'] ?? [],
      category: map['category'],
      brands: map['brands'] ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory FilterUIModel.fromJson(String source) =>
      FilterUIModel.fromMap(json.decode(source));
}
