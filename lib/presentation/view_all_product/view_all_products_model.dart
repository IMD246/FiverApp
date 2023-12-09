import 'package:fiver/core/di/locator_service.dart';
import 'package:fiver/core/enum.dart';
import 'package:fiver/core/extensions/ext_enum.dart';
import 'package:fiver/data/model/product_model.dart';
import 'package:fiver/domain/repositories/common_repository.dart';
import 'package:flutter/foundation.dart';

import '../../core/base/base_list_model.dart';

class ViewAllProductsModel extends BaseListModel<ProductModel> {
  final _repo = locator<CommonRepository>();
  int typeProduct = 0;
  void init(TypeProduct typeProduct) {
    this.typeProduct = typeProduct.getValue();
  }

  @override
  Future<List<ProductModel>?> getData({params, bool? isClear}) async {
    try {
      return await _repo.getProductsByType(
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
}
