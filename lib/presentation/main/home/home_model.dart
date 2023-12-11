import 'dart:isolate';
import 'package:fiver/core/base/base_model.dart';
import 'package:fiver/core/di/locator_service.dart';
import 'package:fiver/core/enum.dart';
import 'package:fiver/core/routes/app_router.dart';
import 'package:fiver/core/utils/isolate_util.dart';
import 'package:fiver/data/model/banner_model.dart';
import 'package:fiver/data/model/product_model.dart';
import 'package:fiver/domain/repositories/common_repository.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/util.dart';

class HomeModel extends BaseModel {
  final _repo = locator<CommonRepository>();
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
      var receiveport = ReceivePort();
      final getBanners = await _repo.getBannerList();
      _isolateBanners = await Isolate.spawn(
        IsolateUtil.sendDataFromPort,
        [
          receiveport.sendPort,
          getBanners,
        ],
      );
      IsolateUtil.killIsolate(isolate: _isolateBanners);
      setValueNotifier(banners, await receiveport.first);
    } catch (e) {
      setValueNotifier(banners, <BannerModel>[]);
    }
  }

  void _getNewProducts() async {
    try {
      var receiveport = ReceivePort();
      final getNewProducts = await _repo.getNewProductList();
      _isolateNewProducts = await Isolate.spawn(
        IsolateUtil.sendDataFromPort,
        [
          receiveport.sendPort,
          getNewProducts,
        ],
      );
      IsolateUtil.killIsolate(isolate: _isolateNewProducts);
      setValueNotifier(newProducts, await receiveport.first);
    } catch (e) {
      setValueNotifier(newProducts, <ProductModel>[]);
    }
  }

  void _getSaleProducts() async {
    try {
      var receiveport = ReceivePort();
      final getSaleProducts = await _repo.getSaleProductList();
      _isolateSaleProducts = await Isolate.spawn(
        IsolateUtil.sendDataFromPort,
        [
          receiveport.sendPort,
          getSaleProducts,
        ],
      );
      IsolateUtil.killIsolate(isolate: _isolateSaleProducts);
      setValueNotifier(saleProducts, await receiveport.first);
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
