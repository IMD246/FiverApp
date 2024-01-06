import 'package:flutter/foundation.dart';

import '../../core/base/base_list_model.dart';
import '../../core/di/locator_service.dart';
import '../../core/enum.dart';
import '../../core/extensions/ext_enum.dart';
import '../../core/routes/app_router.dart';
import '../../data/model/product_model.dart';
import '../../domain/repositories/product_repository.dart';

class ViewAllProductsModel extends BaseListModel<ProductModel> {
  final _productRepo = locator<ProductRepository>();
  int typeProduct = 0;
  void init(TypeProduct typeProduct) {
    this.typeProduct = typeProduct.getValue();
  }

  @override
  Future<List<ProductModel>?> getData({params, bool? isClear}) async {
    try {
      return await _productRepo.getProductsByType(
        typeProduct: typeProduct,
        page: page,
        pageSize: pageSize,
      );
    } catch (e) {
      if (kDebugMode) {
        print("error view all product: $e");
      }
      return [];
    }
  }

  void onToProductDetail(ProductModel item) {
    AppRouter.router.push(
      Uri(
        path: AppRouter.productDetailPath,
        queryParameters: {
          "id": item.id,
          "name": item.name,
        },
      ).toString(),
    );
  }
}
