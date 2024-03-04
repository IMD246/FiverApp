import 'dart:isolate';

import '../../../core/utils/collection_util.dart';
import 'package:flutter/material.dart';

import '../../../core/app/app_model.dart';
import '../../../core/base/base_model.dart';
import '../../../core/di/locator_service.dart';
import '../../../core/event/category_detail_event.dart';
import '../../../core/utils/isolate_util.dart';
import '../../../core/utils/util.dart';
import '../../../data/model/banner_model.dart';
import '../../../data/model/category_model.dart';
import '../../../domain/repositories/category_repository.dart';

class ShopCategoryModel extends BaseModel {
  final _cateRepo = locator<CategoryRepository>();

  Isolate? _isolateCategories;

  final ValueNotifier<List<CategoryModel>> categories = ValueNotifier([]);

  final ValueNotifier<List<CategoryModel>> subCategories = ValueNotifier([]);

  final ValueNotifier<BannerModel?> banner = ValueNotifier(null);

  final ValueNotifier<int> selectedCategory = ValueNotifier(0);

  void init() {
    _getCategories();
  }

  void _getCategories() async {
    try {
      final getCategories = await IsolateUtil.isolateFunction(
          actionFuture: _cateRepo.getCategories, isolate: _isolateCategories);
      setValueNotifier(categories, getCategories);
      if (!categories.value.isNullOrEmpty) {
        setValueNotifier(selectedCategory, categories.value.first.id);
        setValueNotifier(subCategories, categories.value.first.childs ?? []);
        setValueNotifier(banner, categories.value.first.banner);
      }
    } catch (e) {
      setValueNotifier(categories, <CategoryModel>[]);
    }
  }

  void _getSubCategories() async {
    try {
      setValueNotifier(banner, null);
      setValueNotifier(subCategories, <CategoryModel>[]);
      final getCategory =
          await _cateRepo.getCategoryById(selectedCategory.value);
      setValueNotifier(subCategories, getCategory.childs);
      setValueNotifier(banner, getCategory.banner);
    } catch (e) {
      setValueNotifier(subCategories, <CategoryModel>[]);
    }
  }

  void _killAllIsolate() {
    IsolateUtil.killIsolate(isolate: _isolateCategories);
  }

  void updateSelectedCategory(int index) {
    if (index == selectedCategory.value) return;
    setValueNotifier(selectedCategory, index);
    _getSubCategories();
  }

  void onGoToCategoryDetail(CategoryModel category) {
    eventBus.fire(CategoryDetailEvent(category: category));
  }

  @override
  void disposeModel() {
    subCategories.dispose();
    categories.dispose();
    selectedCategory.dispose();
    _killAllIsolate();
    super.disposeModel();
  }
}
