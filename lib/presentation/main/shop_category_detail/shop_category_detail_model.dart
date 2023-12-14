import 'dart:isolate';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../core/app/app_model.dart';
import '../../../core/base/base_list_model.dart';
import '../../../core/di/locator_service.dart';
import '../../../core/event/category_detail_event.dart';
import '../../../core/routes/app_router.dart';
import '../../../core/utils/isolate_util.dart';
import '../../../core/utils/util.dart';
import '../../../data/model/brand_model.dart';
import '../../../data/model/category_model.dart';
import '../../../data/model/filter_ui_model.dart';
import '../../../data/model/product_model.dart';
import '../../../data/model/sort_by_model.dart';
import '../../../domain/repositories/category_repository.dart';
import '../../../domain/repositories/common_repository.dart';
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

  double minPrice = 0;

  double maxPrice = 0;

  List<Color> colors = [];

  List<int> sizes = [];

  ValueNotifier<CategoryModel?> category = ValueNotifier(null);

  List<MBrand> brands = [];

  List<String> colorsCovertedToString = [];

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
    if (this.minPrice != minPrice) {
      this.minPrice = minPrice;
    }
    if (this.maxPrice != maxPrice) {
      this.maxPrice = maxPrice;
    }
  }

  void _updateColors(List<Color> colors) {
    this.colors = colors;
    _convertedColorsToString();
  }

  void _convertedColorsToString() {
    colorsCovertedToString.clear();
    for (Color color in colors) {
      colorsCovertedToString.add(color.value.toString());
    }
  }

  void _updateSizes(List<int> sizes) {
    this.sizes = sizes;
  }

  void _updateCategory(CategoryModel? category) {
    if (this.category.value?.id == category?.id) return;
    setValueNotifier(this.category, category);
  }

  void _updateBrands(List<MBrand> brands) {
    this.brands = brands;
  }

  void updateSortBy(SortByModel? sortBy) async {
    if (this.sortBy.value == sortBy) return;
    if (sortByList.value.isNotEmpty) {
      setValueNotifier(this.sortBy, sortBy);
      await refresh();
    }
  }

  void _applyFilter({
    required FilterUIModel filterUIModel,
  }) async {
    _updateMinMaxPrice(filterUIModel.minPrice, filterUIModel.maxPrice);
    _updateColors(filterUIModel.colors);
    _updateSizes(filterUIModel.sizes);
    _updateBrands(filterUIModel.brands);
    _updateCategory(filterUIModel.category);
    await refresh();
  }

  void init(CategoryModel category) async {
    await _getRangePrice();
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
    SortByModel? sortBy;
    if (isPriceLowestToHigh) {
      sortBy = _getSortByInlistByName("highest");
    } else {
      sortBy = _getSortByInlistByName("lowest");
    }
    updateSortBy(sortBy ?? currentSortBy);
  }

  SortByModel? _getSortByInlistByName(String name) {
    return sortByList.value.firstWhereOrNull(
        (element) => element.name.toLowerCase().contains(name));
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

  Future<void> _getRangePrice() async {
    try {
      final getRangePrice = await _commonRepo.getRangePrice();
      minPrice = getRangePrice.first;
      maxPrice = getRangePrice.last;
    } catch (e) {
      minPrice = 0;
      maxPrice = 0;
    }
  }

  void onGoToFilter() async {
    AppRouter.router
        .push(
      AppRouter.filterPath,
      extra: toMapFilters(
        minPrice: minPrice,
        maxPrice: maxPrice,
        colors: colors,
        sizes: sizes,
        brands: brands,
      ),
    )
        .then((value) {
      if (value != null) {
        final filterModel =
            FilterUIModel.fromMap(value as Map<String, dynamic>);
        _applyFilter(filterUIModel: filterModel);
      }
    });
  }

  List<int> _toBrandsId() {
    if (brands.isEmpty) return [];
    return List<int>.from(brands.map((e) => e.id).toList());
  }

  @override
  Future<List<ProductModel>?> getData({params, bool? isClear}) async {
    try {
      return await _productRepo.getProductsByFilter(
        brands: _toBrandsId(),
        categoryId: category.value?.id,
        colors: colorsCovertedToString,
        maxPrice: maxPrice,
        minPrice: minPrice,
        sizes: sizes,
        sortByType: sortBy.value?.id,
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
    category.dispose();
    _killAllIsolates();
    super.disposeModel();
  }
}
