import 'dart:ui';

import '../../presentation/brand/brand_model.dart';

import 'brand_model.dart';
import 'category_model.dart';

class FilterUIModel {
  final double minPrice;
  final double maxPrice;
  final List<Color> colors;
  final List<int> sizes;
  final CategoryModel? category;
  final List<MBrand> brands;

  FilterUIModel({
    required this.minPrice,
    required this.maxPrice,
    required this.colors,
    required this.sizes,
    required this.category,
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
      sizes: map['sizes'] ?? <int>[],
      category: map['category'],
      brands: map['brands'] ?? <BrandModel>[],
    );
  }
}
