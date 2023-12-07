import 'dart:developer';
import 'dart:io';
import 'dart:isolate';

import 'package:fiver/core/base/base_model.dart';
import 'package:fiver/core/di/locator_service.dart';
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
        _sendDataFromPort,
        [
          receiveport.sendPort,
          getBanners,
        ],
      );
      isolateBanners?.kill(priority: Isolate.immediate);
      _setValueNotifier(banners, await receiveport.first);
    } catch (e) {
      log("isolateerror:$e");
      _setValueNotifier(banners, []);
    }
  }

  static void _sendDataFromPort(List<dynamic> params) {
    final SendPort sp = params[0];
    sp.send(params[1]);
  }

  void getNewProducts() async {
    try {
      var receiveport = ReceivePort();
      final getNewProducts = await _repo.getNewProductList();
      isolateNewProducts = await Isolate.spawn(
        _sendDataFromPort,
        [
          receiveport.sendPort,
          getNewProducts,
        ],
      );
      isolateNewProducts?.kill(priority: Isolate.immediate);
      _setValueNotifier(newProducts, await receiveport.first);
    } catch (e) {
      _setValueNotifier(newProducts, []);
      log("new Products home: $e");
    }
  }

  void getSaleProducts() async {
    try {
      var receiveport = ReceivePort();
      final getSaleProducts = await _repo.getSaleProductList();
      isolateSaleProducts = await Isolate.spawn(
        _sendDataFromPort,
        [
          receiveport.sendPort,
          getSaleProducts,
        ],
      );
      isolateSaleProducts?.kill(priority: Isolate.immediate);
      _setValueNotifier(saleProducts, await receiveport.first);
    } catch (e) {
      _setValueNotifier(saleProducts, []);
      log("sale Products home: $e");
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
    isolateBanners?.kill(priority: Isolate.immediate);
    isolateNewProducts?.kill(priority: Isolate.immediate);
    isolateSaleProducts?.kill(priority: Isolate.immediate);
  }
}
