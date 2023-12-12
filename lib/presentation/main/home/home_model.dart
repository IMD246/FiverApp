import 'dart:isolate';
import 'package:fiver/core/base/base_model.dart';
import 'package:fiver/core/di/locator_service.dart';
import 'package:fiver/core/enum.dart';
import 'package:fiver/core/routes/app_router.dart';
import 'package:fiver/core/utils/isolate_util.dart';
import 'package:fiver/data/model/banner_model.dart';
import 'package:fiver/data/model/product_model.dart';
import 'package:fiver/domain/repositories/common_repository.dart';
import 'package:fiver/domain/repositories/product_repository.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/util.dart';

class HomeModel extends BaseModel {
  final _repo = locator<CommonRepository>();
  final _productRepo = locator<ProductRepository>();
  final ValueNotifier<List<BannerModel>> banners = ValueNotifier([]);
  final ValueNotifier<List<ProductModel>> saleProducts = ValueNotifier([]);
  final ValueNotifier<List<ProductModel>> newProducts = ValueNotifier([]);
  Isolate? _isolateBanners;
  Isolate? _isolateSaleProducts;
  Isolate? _isolateNewProducts;

  void init() {
    _getBanners();
    _getNewProducts();
    _getSaleProducts();
  }

  void refresh() {
    _killAllIsolate();
    init();
  }

  void _killAllIsolate() {
    IsolateUtil.killIsolate(isolate: _isolateBanners);
    IsolateUtil.killIsolate(isolate: _isolateSaleProducts);
    IsolateUtil.killIsolate(isolate: _isolateNewProducts);
  }

  void _getBanners() async {
    try {
      final getBanners = await IsolateUtil.isolateFunction(
        actionFuture: _repo.getBannerList,
        isolate: _isolateBanners,
      );
      setValueNotifier(banners, getBanners);
    } catch (e) {
      setValueNotifier(banners, <BannerModel>[]);
    }
  }

  void _getNewProducts() async {
    try {
      final getNewProducts = await IsolateUtil.isolateFunction(
        actionFuture: _productRepo.getNewProductList,
        isolate: _isolateNewProducts,
      );

      setValueNotifier(newProducts, getNewProducts);
    } catch (e) {
      setValueNotifier(newProducts, <ProductModel>[]);
    }
  }

  void _getSaleProducts() async {
    try {
      final getSaleProducts = await IsolateUtil.isolateFunction(
        actionFuture: _productRepo.getSaleProductList,
        isolate: _isolateSaleProducts,
      );
      setValueNotifier(saleProducts, getSaleProducts);
    } catch (e) {
      setValueNotifier(saleProducts, <ProductModel>[]);
    }
  }

  void onGoToViewAllProducts(TypeProduct typeProduct) async {
    AppRouter.router.push(
      AppRouter.viewAllProductsPath,
      extra: typeProduct,
    );
  }

  @override
  void disposeModel() {
    banners.dispose();
    saleProducts.dispose();
    newProducts.dispose();
    _killAllIsolate();
    super.disposeModel();
  }
}
