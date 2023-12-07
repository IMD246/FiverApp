import 'dart:isolate';
import 'package:fiver/core/base/base_model.dart';
import 'package:fiver/core/di/locator_service.dart';
import 'package:fiver/core/utils/isolate_util.dart';
import 'package:fiver/data/model/banner_model.dart';
import 'package:fiver/data/model/product_model.dart';
import 'package:fiver/domain/repositories/common_repository.dart';
import 'package:flutter/material.dart';

class HomeModel extends BaseModel {
  final _repo = locator<CommonRepository>();
  final ValueNotifier<List<BannerModel>> banners = ValueNotifier([]);
  final ValueNotifier<List<ProductModel>> saleProducts = ValueNotifier([]);
  final ValueNotifier<List<ProductModel>> newProducts = ValueNotifier([]);
  Isolate? isolateBanners;
  Isolate? isolateSaleProducts;
  Isolate? isolateNewProducts;
  
  void init() {
    getBanners();
    getNewProducts();
    getSaleProducts();
  }

  void refresh() {
    init();
  }

  void getBanners() async {
    try {
      var receiveport = ReceivePort();
      final getBanners = await _repo.getBannerList();
      isolateBanners = await Isolate.spawn(
        IsolateUtil.sendDataFromPort,
        [
          receiveport.sendPort,
          getBanners,
        ],
      );
      IsolateUtil.killIsolate(isolate: isolateBanners);
      _setValueNotifier(banners, await receiveport.first);
    } catch (e) {
      _setValueNotifier(banners, []);
    }
  }

  void getNewProducts() async {
    try {
      var receiveport = ReceivePort();
      final getNewProducts = await _repo.getNewProductList();
      isolateNewProducts = await Isolate.spawn(
        IsolateUtil.sendDataFromPort,
        [
          receiveport.sendPort,
          getNewProducts,
        ],
      );
      IsolateUtil.killIsolate(isolate: isolateNewProducts);
      _setValueNotifier(newProducts, await receiveport.first);
    } catch (e) {
      _setValueNotifier(newProducts, []);
    }
  }

  void getSaleProducts() async {
    try {
      var receiveport = ReceivePort();
      final getSaleProducts = await _repo.getSaleProductList();
      isolateSaleProducts = await Isolate.spawn(
        IsolateUtil.sendDataFromPort,
        [
          receiveport.sendPort,
          getSaleProducts,
        ],
      );
      IsolateUtil.killIsolate(isolate: isolateSaleProducts);
      _setValueNotifier(saleProducts, await receiveport.first);
    } catch (e) {
      _setValueNotifier(saleProducts, []);
    }
  }

  void _setValueNotifier(ValueNotifier notifier, dynamic value) {
    notifier.value = value;
  }

  @override
  void disposeModel() {
    banners.dispose();
    saleProducts.dispose();
    newProducts.dispose();
    IsolateUtil.killIsolate(isolate: isolateBanners);
    IsolateUtil.killIsolate(isolate: isolateNewProducts);
    IsolateUtil.killIsolate(isolate: isolateSaleProducts);
  }
}
