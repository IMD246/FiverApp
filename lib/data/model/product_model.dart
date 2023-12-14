import 'dart:core';

class ProductModel {
  final String name;
  final String brandName;
  final num originPrice;
  final num price;
  final String urlImage;
  final num salePercent;
  final bool isNew;

  ProductModel({
    required this.name,
    required this.brandName,
    required this.originPrice,
    required this.price,
    required this.urlImage,
    required this.salePercent,
    this.isNew = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'brandName': brandName,
      'originPrice': originPrice,
      'price': price,
      'urlImage': urlImage,
      'salePercent': salePercent,
      'isNew': isNew,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: map['name'] ?? '',
      brandName: map['brandName'] ?? '',
      originPrice: map['originPrice'] ?? 0,
      price: map['price'] ?? 0,
      urlImage: map['urlImage'] ?? '',
      salePercent: map['salePercent'] ?? 0,
      isNew: map['isNew'] ?? false,
    );
  }
}
