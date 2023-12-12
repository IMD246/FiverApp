import '../../core/base/base_service.dart';
import '../model/product_model.dart';

import '../../domain/repositories/product_repository.dart';

class ProductRepositoryImp extends BaseSerivce implements ProductRepository {
  @override
  Future<List<ProductModel>> getSaleProductList() async {
    return [
      ProductModel(
          name: "Evening Dress",
          brandName: "Dorothy Perkins",
          originPrice: 15,
          price: 12,
          urlImage:
              "https://images.squarespace-cdn.com/content/v1/528f8b33e4b01f2a315145b2/1473165174041-ELTK3U8JIOQRWBV330P7/static1.squarespace-13.jpg",
          salePercent: "-3%"),
      ProductModel(
          name: "Sport Dress",
          brandName: "Sitlly",
          originPrice: 22,
          price: 19,
          urlImage:
              "https://images.squarespace-cdn.com/content/v1/528f8b33e4b01f2a315145b2/1473165174041-ELTK3U8JIOQRWBV330P7/static1.squarespace-13.jpg",
          salePercent: "-5%"),
      ProductModel(
          name: "Evening Dres1s",
          brandName: "Dorothy Perkins1",
          originPrice: 14,
          price: 11,
          urlImage:
              "https://images.squarespace-cdn.com/content/v1/528f8b33e4b01f2a315145b2/1473165174041-ELTK3U8JIOQRWBV330P7/static1.squarespace-13.jpg",
          salePercent: "-7%"),
    ];
  }

  @override
  Future<List<ProductModel>> getNewProductList() async {
    return [
      ProductModel(
          name: "Evening Dress",
          brandName: "Dorothy Perkins",
          originPrice: 15,
          price: 12,
          urlImage:
              "https://images.squarespace-cdn.com/content/v1/528f8b33e4b01f2a315145b2/1473165174041-ELTK3U8JIOQRWBV330P7/static1.squarespace-13.jpg",
          salePercent: "-3%"),
      ProductModel(
          name: "Sport Dress",
          brandName: "Sitlly",
          originPrice: 22,
          price: 19,
          urlImage:
              "https://images.squarespace-cdn.com/content/v1/528f8b33e4b01f2a315145b2/1473165174041-ELTK3U8JIOQRWBV330P7/static1.squarespace-13.jpg",
          salePercent: "-5%"),
      ProductModel(
          name: "Evening Dres1s",
          brandName: "Dorothy Perkins1",
          originPrice: 14,
          price: 11,
          urlImage:
              "https://images.squarespace-cdn.com/content/v1/528f8b33e4b01f2a315145b2/1473165174041-ELTK3U8JIOQRWBV330P7/static1.squarespace-13.jpg",
          salePercent: "-7%"),
    ];
  }

  @override
  Future<List<ProductModel>> getProductsByType({
    required int page,
    required int pageSize,
    required int typeProduct,
  }) async {
    return [
      ProductModel(
          name: "Evening Dress",
          brandName: "Dorothy Perkins",
          originPrice: 15,
          price: 12,
          urlImage:
              "https://images.squarespace-cdn.com/content/v1/528f8b33e4b01f2a315145b2/1473165174041-ELTK3U8JIOQRWBV330P7/static1.squarespace-13.jpg",
          salePercent: "-3%"),
      ProductModel(
          name: "Sport Dress",
          brandName: "Sitlly",
          originPrice: 22,
          price: 19,
          urlImage:
              "https://images.squarespace-cdn.com/content/v1/528f8b33e4b01f2a315145b2/1473165174041-ELTK3U8JIOQRWBV330P7/static1.squarespace-13.jpg",
          salePercent: "-5%"),
      ProductModel(
          name: "Evening Dres1s",
          brandName: "Dorothy Perkins1",
          originPrice: 14,
          price: 11,
          urlImage:
              "https://images.squarespace-cdn.com/content/v1/528f8b33e4b01f2a315145b2/1473165174041-ELTK3U8JIOQRWBV330P7/static1.squarespace-13.jpg",
          salePercent: "-7%"),
      ProductModel(
          name: "Evening Dress",
          brandName: "Dorothy Perkins",
          originPrice: 15,
          price: 12,
          urlImage:
              "https://images.squarespace-cdn.com/content/v1/528f8b33e4b01f2a315145b2/1473165174041-ELTK3U8JIOQRWBV330P7/static1.squarespace-13.jpg",
          salePercent: "-3%"),
      ProductModel(
          name: "Sport Dress",
          brandName: "Sitlly",
          originPrice: 22,
          price: 19,
          urlImage:
              "https://images.squarespace-cdn.com/content/v1/528f8b33e4b01f2a315145b2/1473165174041-ELTK3U8JIOQRWBV330P7/static1.squarespace-13.jpg",
          salePercent: "-5%"),
      ProductModel(
          name: "Evening Dres1s",
          brandName: "Dorothy Perkins1",
          originPrice: 14,
          price: 11,
          urlImage:
              "https://images.squarespace-cdn.com/content/v1/528f8b33e4b01f2a315145b2/1473165174041-ELTK3U8JIOQRWBV330P7/static1.squarespace-13.jpg",
          salePercent: "-7%"),
    ];
  }

  @override
  Future<List<ProductModel>> getProductsByFilter({
    int? sortByType,
    double? minPrice,
    double? maxPrice,
    List<String>? colors,
    List<int>? sizes,
    int? categoryId,
    List<int>? brands,
    required int page,
    required int pageSize,
  }) async {
    return [
      ProductModel(
          name: "Evening Dress",
          brandName: "Dorothy Perkins",
          originPrice: 15,
          price: 12,
          urlImage:
              "https://images.squarespace-cdn.com/content/v1/528f8b33e4b01f2a315145b2/1473165174041-ELTK3U8JIOQRWBV330P7/static1.squarespace-13.jpg",
          salePercent: "-3%"),
      ProductModel(
          name: "Sport Dress",
          brandName: "Sitlly",
          originPrice: 22,
          price: 19,
          urlImage:
              "https://images.squarespace-cdn.com/content/v1/528f8b33e4b01f2a315145b2/1473165174041-ELTK3U8JIOQRWBV330P7/static1.squarespace-13.jpg",
          salePercent: "-5%"),
      ProductModel(
          name: "Evening Dres1s",
          brandName: "Dorothy Perkins1",
          originPrice: 14,
          price: 11,
          urlImage:
              "https://images.squarespace-cdn.com/content/v1/528f8b33e4b01f2a315145b2/1473165174041-ELTK3U8JIOQRWBV330P7/static1.squarespace-13.jpg",
          salePercent: "-7%"),
      ProductModel(
          name: "Evening Dress",
          brandName: "Dorothy Perkins",
          originPrice: 15,
          price: 12,
          urlImage:
              "https://images.squarespace-cdn.com/content/v1/528f8b33e4b01f2a315145b2/1473165174041-ELTK3U8JIOQRWBV330P7/static1.squarespace-13.jpg",
          salePercent: "-3%"),
      ProductModel(
          name: "Sport Dress",
          brandName: "Sitlly",
          originPrice: 22,
          price: 19,
          urlImage:
              "https://images.squarespace-cdn.com/content/v1/528f8b33e4b01f2a315145b2/1473165174041-ELTK3U8JIOQRWBV330P7/static1.squarespace-13.jpg",
          salePercent: "-5%"),
      ProductModel(
          name: "Evening Dres1s",
          brandName: "Dorothy Perkins1",
          originPrice: 14,
          price: 11,
          urlImage:
              "https://images.squarespace-cdn.com/content/v1/528f8b33e4b01f2a315145b2/1473165174041-ELTK3U8JIOQRWBV330P7/static1.squarespace-13.jpg",
          salePercent: "-7%"),
    ];
  }
}
