import 'dart:isolate';

import '../../../core/app/app_model.dart';
import '../../../core/di/locator_service.dart';
import '../../../core/routes/app_router.dart';
import '../../../core/utils/util.dart';
import '../../../data/model/brand_model.dart';
import '../../../data/model/category_model.dart';
import '../../../data/model/filter_ui_model.dart';
import '../../../data/model/product_model.dart';
import '../../../data/model/sort_by_model.dart';
import '../../../domain/repositories/category_repository.dart';
import '../../../domain/repositories/common_repository.dart';
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

  ValueNotifier<double> maxPrice = ValueNotifier(0);

  ValueNotifier<List<Color>> colors = ValueNotifier([]);

  ValueNotifier<List<int>> sizes = ValueNotifier([]);

  ValueNotifier<CategoryModel?> category = ValueNotifier(null);

  ValueNotifier<List<MBrand>> brands = ValueNotifier([]);

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
    if (this.minPrice.value != minPrice) {
      setValueNotifier(this.minPrice, minPrice);
    }
    if (this.maxPrice.value != maxPrice) {
      setValueNotifier(this.maxPrice, maxPrice);
    }
  }

  void _updateColors(List<Color> colors) {
    if (colors.isEmpty) {
      setValueNotifier(this.colors, <Color>[]);
    } else {
      setValueNotifier(this.colors, colors);
    }
    _convertedColorsToString();
  }

  void _convertedColorsToString() {
    final colors = this.colors.value;
    colorsCovertedToString.clear();
    for (Color color in colors) {
      colorsCovertedToString.add(color.value.toString());
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
    if (this.category.value?.id == category?.id) return;
    setValueNotifier(this.category, category);
  }

  void _updateBrands(List<MBrand> brands) {
    if (brands.isEmpty) {
      setValueNotifier(this.brands, <int>[]);
    } else {
      setValueNotifier(this.brands, brands);
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
    required FilterUIModel filterUIModel,
  }) async {
    _updateMinMaxPrice(filterUIModel.minPrice, filterUIModel.maxPrice);
    _updateColors(filterUIModel.colors);
    _updateSizes(filterUIModel.sizes);
    _updateBrands(filterUIModel.brands);
    _updateCategory(filterUIModel.category);
    await refresh();
  }

  void init(CategoryModel category) {
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

  void onGoToFilter() async {
    AppRouter.router
        .push(
      AppRouter.filterPath,
      extra: toMapFilters(
        minPrice: minPrice.value,
        maxPrice: maxPrice.value,
        colors: colors.value,
        sizes: sizes.value,
        brands: brands.value,
      ),
    )
        .then((value) {
      if (value != null) {
        final filterModel =
            FilterUIModel.fromMap(value as Map<String, dynamic>);
        applyFilter(filterUIModel: filterModel);
      }
    });
  }

  List<int> _toBrandsId() {
    if (brands.value.isEmpty) return [];
    return List<int>.from(brands.value.map((e) => e.id).toList());
  }

  @override
  Future<List<ProductModel>?> getData({params, bool? isClear}) async {
    try {
      return await _productRepo.getProductsByFilter(
        brands: _toBrandsId(),
        categoryId: category.value?.id,
        colors: colorsCovertedToString,
        maxPrice: maxPrice.value,
        minPrice: minPrice.value,
        sizes: sizes.value,
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
    minPrice.dispose();
    maxPrice.dispose();
    colors.dispose();
    sizes.dispose();
    category.dispose();
    brands.dispose();
    _killAllIsolates();
    super.disposeModel();
  }
}
