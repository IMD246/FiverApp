import 'dart:convert';
import 'dart:core';

class ProductModel {
  final String name;
  final String brandName;
  final num originPrice;
  final num price;
  final String urlImage;
  final String salePercent;

  ProductModel({
    required this.name,
    required this.brandName,
    required this.originPrice,
    required this.price,
    required this.urlImage,
    required this.salePercent,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'brandName': brandName,
      'originPrice': originPrice,
      'price': price,
      'urlImage': urlImage,
      'salePercent': salePercent,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: map['name'] ?? '',
      brandName: map['brandName'] ?? '',
      originPrice: map['originPrice'] ?? 0,
      price: map['price'] ?? 0,
      urlImage: map['urlImage'] ?? '',
      salePercent: map['salePercent'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));
}
