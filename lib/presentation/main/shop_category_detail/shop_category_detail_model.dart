import 'dart:isolate';

import 'package:fiver/core/app/app_model.dart';
import 'package:fiver/core/di/locator_service.dart';
import 'package:fiver/core/utils/util.dart';
import 'package:fiver/data/model/category_model.dart';
import 'package:fiver/data/model/product_model.dart';
import 'package:fiver/data/model/sort_by_model.dart';
import 'package:fiver/domain/repositories/category_repository.dart';
import 'package:fiver/domain/repositories/common_repository.dart';
import 'package:flutter/material.dart';

import '../../../core/base/base_list_model.dart';
import '../../../core/event/category_detail_event.dart';
import '../../../core/utils/isolate_util.dart';
import '../../../domain/repositories/product_repository.dart';

class ShopCategoryDetailModel extends BaseListModel<ProductModel> {
  final _productRepo = locator<ProductRepository>();
  final _categoryRepo = locator<CategoryRepository>();
  final _commonRepo = locator<CommonRepository>();

  Isolate? _isolateSortByList;
  Isolate? _isolateProductCategories;

  ValueNotifier<List<CategoryModel>> productCategories = ValueNotifier([]);

  ValueNotifier<List<SortByModel>> sortByList = ValueNotifier([]);

  ValueNotifier<int?> productCategoryIndex = ValueNotifier(null);

  ValueNotifier<SortByModel?> sortBy = ValueNotifier(null);

  ValueNotifier<double> minPrice = ValueNotifier(0);

  ValueNotifier<double> maxPrice = ValueNotifier(143);

  ValueNotifier<List<Colors>> colors = ValueNotifier([]);

  ValueNotifier<List<int>> sizes = ValueNotifier([]);

  ValueNotifier<CategoryModel?> category = ValueNotifier(null);

  ValueNotifier<List<int>> idBrands = ValueNotifier([]);

  List<String> colorsCovertedToString = [];

  late final CategoryModel categoryModel;

  void updateProductCategoryIndex(int? index) async {
    if (productCategoryIndex.value == index) return;
    setValueNotifier(productCategoryIndex, index);
    await refresh();
  }

  void _getSortByList() async {
    try {
      final getSortByList = await IsolateUtil.isolateFunction(
          actionFuture: _commonRepo.getSortByList, isolate: _isolateSortByList);
      setValueNotifier(sortByList, getSortByList);
    } catch (e) {
      setValueNotifier(sortByList, <SortByModel>[]);
    }
  }

  void _updateMinMaxPrice(double minPrice, double maxPrice) {
    if (this.minPrice.value != minPrice) {
      setValueNotifier(this.minPrice, minPrice);
    }
    if (this.maxPrice.value != maxPrice) {
      setValueNotifier(this.maxPrice, maxPrice);
    }
  }

  void _updateColors(List<Colors> colors) {
    if (colors.isEmpty) {
      setValueNotifier(this.colors, <Colors>[]);
    } else {
      setValueNotifier(this.colors, colors);
    }
    _convertedColorsToString();
  }

  void _convertedColorsToString() {
    final colors = this.colors.value;
    colorsCovertedToString.clear();
    for (Colors color in colors) {
      colorsCovertedToString.add(color.toString());
    }
  }

  void _updateSizes(List<int> sizes) {
    if (sizes.isEmpty) {
      setValueNotifier(this.sizes, <int>[]);
    } else {
      setValueNotifier(this.sizes, sizes);
    }
  }

  void _updateCategory(CategoryModel? category) {
    if (this.category.value?.uid == category?.uid) return;
    setValueNotifier(this.category, category);
  }

  void _updateBrands(List<int> idBrands) {
    if (idBrands.isEmpty) {
      setValueNotifier(this.idBrands, <int>[]);
    } else {
      setValueNotifier(this.idBrands, idBrands);
    }
  }

  void updateSortBy(SortByModel? sortBy) async {
    if (this.sortBy.value == sortBy) return;
    if (sortByList.value.isNotEmpty) {
      setValueNotifier(this.sortBy, sortBy);
      await refresh();
    }
  }

  void applyFilter({
    required double minPrice,
    required double maxPrice,
    required List<Colors> colors,
    required List<int> sizes,
    required List<int> brands,
    required CategoryModel categoryModel,
  }) async {
    _updateMinMaxPrice(minPrice, maxPrice);
    _updateColors(colors);
    _updateSizes(sizes);
    _updateBrands(brands);
    _updateCategory(categoryModel);
    await refresh();
  }

  void init(CategoryModel category) {
    categoryModel = category;
    setValueNotifier(this.category, category);
    _getProductCategories();
    _getSortByList();
  }

  void onBack() {
    eventBus.fire(CategoryDetailEvent(category: null));
  }

  void reverseSortBy(SortByModel currentSortBy) {
    final isPriceLowestToHigh =
        currentSortBy.name.toLowerCase().contains("lowest");
    late SortByModel sortBy;
    if (isPriceLowestToHigh) {
      sortBy = _getSortByInlistByName("highest");
    } else {
      sortBy = _getSortByInlistByName("lowest");
    }
    updateSortBy(sortBy);
  }

  SortByModel _getSortByInlistByName(String name) {
    return sortByList.value
        .firstWhere((element) => element.name.toLowerCase().contains(name));
  }

  void _getProductCategories() async {
    try {
      final getProductCategories = await IsolateUtil.isolateFunction(
          actionFuture: _categoryRepo.getProductCategories,
          isolate: _isolateProductCategories);
      setValueNotifier(productCategories, getProductCategories);
    } catch (e) {
      setValueNotifier(productCategories, <CategoryModel>[]);
    }
  }

  void onGoToFilter() async {}

  @override
  Future<List<ProductModel>?> getData({params, bool? isClear}) async {
    try {
      return await _productRepo.getProductsByFilter(
        brands: idBrands.value,
        categoryId: 1,
        colors: colorsCovertedToString,
        maxPrice: maxPrice.value,
        minPrice: minPrice.value,
        sizes: sizes.value,
        // sortByType: sortBy.value,
        sortByType: 1,
        page: page,
        pageSize: pageSize,
      );
    } catch (e) {
      return [];
    }
  }

  void _killAllIsolates() {
    IsolateUtil.killIsolate(isolate: _isolateSortByList);
    IsolateUtil.killIsolate(isolate: _isolateProductCategories);
  }

  @override
  void disposeModel() {
    productCategories.dispose();
    sortByList.dispose();
    productCategoryIndex.dispose();
    sortBy.dispose();
    minPrice.dispose();
    maxPrice.dispose();
    colors.dispose();
    sizes.dispose();
    category.dispose();
    idBrands.dispose();
    _killAllIsolates();
    super.disposeModel();
  }
}
