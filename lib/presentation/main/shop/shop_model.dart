import 'dart:isolate';

import 'package:fiver/core/base/base_model.dart';
import 'package:fiver/core/utils/isolate_util.dart';
import 'package:fiver/data/model/category_model.dart';
import 'package:fiver/data/model/gender_model.dart';
import 'package:fiver/domain/repositories/category_repository.dart';
import 'package:fiver/domain/repositories/common_repository.dart';
import 'package:flutter/material.dart';

import '../../../core/di/locator_service.dart';
import '../../../core/utils/util.dart';

class ShopModel extends BaseModel {
  final _commonRepo = locator<CommonRepository>();
  final _cateRepo = locator<CategoryReopsitory>();

  Isolate? _isolateCategories;
  Isolate? _isolateGenders;

  final ValueNotifier<List<GenderModel>> genders = ValueNotifier([]);
  final ValueNotifier<List<CateogoryModel>> categories = ValueNotifier([]);

  final ValueNotifier<int> selectedGenderIndex = ValueNotifier(0);

  void init() {
    _getCategories();
    _getGenders();
  }

  void _getCategories() async {
    try {
      var receiveport = ReceivePort();
      final getCategories = await _cateRepo.getCategories();
      _isolateCategories = await Isolate.spawn(
        IsolateUtil.sendDataFromPort,
        [
          receiveport.sendPort,
          getCategories,
        ],
      );
      IsolateUtil.killIsolate(isolate: _isolateCategories);
      setValueNotifier(categories, await receiveport.first);
    } catch (e) {
      setValueNotifier(categories, <CateogoryModel>[]);
    }
  }

  void _getGenders() async {
    try {
      var receiveport = ReceivePort();
      final getGenders = await _commonRepo.getGenders();
      _isolateCategories = await Isolate.spawn(
        IsolateUtil.sendDataFromPort,
        [
          receiveport.sendPort,
          getGenders,
        ],
      );
      IsolateUtil.killIsolate(isolate: _isolateGenders);
      setValueNotifier(genders, await receiveport.first);
    } catch (e) {
      setValueNotifier(genders, <GenderModel>[]);
    }
  }

  void _killAllIsolate() {
    IsolateUtil.killIsolate(isolate: _isolateCategories);
    IsolateUtil.killIsolate(isolate: _isolateGenders);
  }

  void updateSelectedGenderIndex(int index) {
    if (index == selectedGenderIndex.value) return;
    setValueNotifier(selectedGenderIndex, index);
    setValueNotifier(categories, <CateogoryModel>[]);
    _getCategories();
  }

  @override
  void disposeModel() {
    genders.dispose();
    categories.dispose();
    _killAllIsolate();
    super.disposeModel();
  }
}
