import 'package:fiver/data/model/banner_model.dart';
import 'package:fiver/data/model/product_model.dart';

abstract class CommonRepository {
  Future<List<BannerModel>> getBannerList();
  Future<List<ProductModel>> getSaleProductList();
  Future<List<ProductModel>> getNewProductList();
  Future<List<ProductModel>> getProductsByType({
    required int page,
    required int pageSize,
    required int typeProduct,
  });
}
