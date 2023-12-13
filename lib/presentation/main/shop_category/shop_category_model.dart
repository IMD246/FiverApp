import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../core/app/app_model.dart';
import '../../../core/base/base_model.dart';
import '../../../core/di/locator_service.dart';
import '../../../core/event/category_detail_event.dart';
import '../../../core/utils/isolate_util.dart';
import '../../../core/utils/util.dart';
import '../../../data/model/category_model.dart';
import '../../../data/model/gender_model.dart';
import '../../../domain/repositories/category_repository.dart';
import '../../../domain/repositories/common_repository.dart';

class ShopCategoryModel extends BaseModel {
  final _commonRepo = locator<CommonRepository>();
  final _cateRepo = locator<CategoryRepository>();

  Isolate? _isolateCategories;
  Isolate? _isolateGenders;

  final ValueNotifier<List<GenderModel>> genders = ValueNotifier([]);
  final ValueNotifier<List<CategoryModel>> categories = ValueNotifier([]);

  final ValueNotifier<int> selectedGenderIndex = ValueNotifier(0);

  void init() {
    _getCategories();
    _getGenders();
  }

  void _getCategories() async {
    try {
      final getCategories = await IsolateUtil.isolateFunction(
          actionFuture: _cateRepo.getCategories, isolate: _isolateCategories);
      setValueNotifier(categories, getCategories);
    } catch (e) {
      setValueNotifier(categories, <CategoryModel>[]);
    }
  }

  void _getGenders() async {
    try {
      final getGenders = await IsolateUtil.isolateFunction(
        actionFuture: _commonRepo.getGenders,
        isolate: _isolateGenders,
      );

      setValueNotifier(genders, getGenders);
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
    setValueNotifier(categories, <CategoryModel>[]);
    _getCategories();
  }

  void onGoToCategoryDetail(CategoryModel category) {
    eventBus.fire(CategoryDetailEvent(category: category));
  }

  @override
  void disposeModel() {
    genders.dispose();
    categories.dispose();
    selectedGenderIndex.dispose();
    _killAllIsolate();
    super.disposeModel();
  }
}
