import 'package:fiver/data/model/product_model.dart';

abstract class ProductRepository {
  Future<List<ProductModel>> getSaleProductList();
  Future<List<ProductModel>> getNewProductList();
  Future<List<ProductModel>> getProductsByType({
    required int page,
    required int pageSize,
    required int typeProduct,
  });
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
  });
}
