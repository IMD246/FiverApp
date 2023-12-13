import 'dart:isolate';

import '../../core/base/base_model.dart';
import '../../core/utils/isolate_util.dart';
import '../../data/model/brand_model.dart';
import '../../data/model/size_model.dart';
import 'package:flutter/material.dart';
import '../../core/di/locator_service.dart';
import '../../core/routes/app_router.dart';
import '../../core/utils/util.dart';
import '../../data/model/category_model.dart';
import '../../data/model/filter_ui_model.dart';
import '../../domain/repositories/common_repository.dart';

class FilterModel extends BaseModel {
  final _commonRepo = locator<CommonRepository>();

  Isolate? _isolateSizes;
  Isolate? _isolateColors;
  Isolate? _isolateRangePrice;

  ValueNotifier<RangeValues> rangePriceSelected =
      ValueNotifier(const RangeValues(0, 0));

  ValueNotifier<RangeValues?> rangePrice = ValueNotifier(null);

  ValueNotifier<List<Color>> colorsSelected = ValueNotifier([]);

  ValueNotifier<List<Color>> colors = ValueNotifier([]);

  ValueNotifier<List<int>> sizesSelected = ValueNotifier([]);

  ValueNotifier<List<SizeModel>> sizes = ValueNotifier([]);

  ValueNotifier<CategoryModel?> categorySelected = ValueNotifier(null);

  ValueNotifier<List<BrandModel>> brandsSelected = ValueNotifier([]);

  ValueNotifier<bool> isReadyOnApply = ValueNotifier(false);

  void init(FilterUIModel? filterModel) async {
    await Future.wait([
      _getSizes(),
      _getColors(),
      _getRangePrice(),
    ]).whenComplete(() {
      setValueNotifier(isReadyOnApply, true);
    });

    _updateSizes(filterModel?.sizes ?? []);
    _updateColors(filterModel?.colors ?? <Color>[]);
    updateCategory(filterModel?.category);
    updateBrands(filterModel?.brands ?? []);
    updateRangeValues(
      RangeValues(
        filterModel?.minPrice ?? 0,
        filterModel?.maxPrice ?? 0,
      ),
    );
  }

  Future<void> _getSizes() async {
    try {
      final getSizes = await IsolateUtil.isolateFunction(
          actionFuture: _commonRepo.getSizes, isolate: _isolateSizes);
      setValueNotifier(sizes, getSizes);
    } catch (e) {
      setValueNotifier(sizes, <SizeModel>[]);
    }
  }

  Future<void> _getColors() async {
    try {
      final getColors = await IsolateUtil.isolateFunction(
          actionFuture: _commonRepo.getColors, isolate: _isolateColors);
      setValueNotifier(colors, getColors);
    } catch (e) {
      setValueNotifier(colors, <SizeModel>[]);
    }
  }

  Future<void> _getRangePrice() async {
    try {
      final getRangePrice = await IsolateUtil.isolateFunction(
        actionFuture: _commonRepo.getRangePrice,
        isolate: _isolateRangePrice,
      );
      setValueNotifier(
        rangePrice,
        RangeValues(
          getRangePrice.first,
          getRangePrice.last,
        ),
      );
    } catch (e) {
      setValueNotifier(
        rangePrice,
        null,
      );
    }
  }

  void updateRangeValues(RangeValues rangeValues) {
    rangePriceSelected.value = rangeValues;
  }

  void _updateSizes(List<int> sizes) {
    if (sizes.isEmpty) {
      setValueNotifier(sizesSelected, <int>[]);
    } else {
      setValueNotifier(sizesSelected, sizes);
    }
  }

  void updateSize(int sizeId) {
    final sizes = sizesSelected.value;
    if (sizes.any((element) => element == sizeId)) {
      sizes.remove(sizeId);
    } else {
      sizes.add(sizeId);
    }
  }

  void updateCategory(CategoryModel? category) {
    if (categorySelected.value?.uid == category?.uid) return;
    setValueNotifier(categorySelected, category);
  }

  void updateBrands(List<BrandModel> brands) {
    if (brands.isEmpty) {
      setValueNotifier(brandsSelected, <BrandModel>[]);
    } else {
      setValueNotifier(brandsSelected, brands);
    }
  }

  void _updateColors(List<Color> colors) {
    if (colors.isEmpty) {
      setValueNotifier(colorsSelected, <Color>[]);
    } else {
      setValueNotifier(colorsSelected, colors);
    }
  }

  void updateColor(Color color) {
    final colors = colorsSelected.value;
    if (colors.any((element) => element == color)) {
      colorsSelected.value.remove(color);
    } else {
      colorsSelected.value.add(color);
    }
    setValueNotifier(colorsSelected, colors);
  }

  void onBack({bool newUpdate = true}) {
    AppRouter.router.pop(
      newUpdate
          ? toMapFilters(
              minPrice: rangePriceSelected.value.start,
              maxPrice: rangePriceSelected.value.end,
              colors: colorsSelected.value,
              sizes: sizesSelected.value,
              brands: brandsSelected.value,
              category: categorySelected.value,
            )
          : null,
    );
  }

  void onApply() {
    onBack();
  }

  void onDiscard() {
    onBack(newUpdate: false);
  }

  String getBrandsName() {
    String name = "";
    final brands = brandsSelected.value;
    for (var i = 0; i < brands.length; i++) {
      if (i == brands.length - 1) {
        name += brands[i].name;
      } else {
        name += "${brands[i].name}, ";
      }
    }
    return name;
  }

  void _killAllIsolates() {
    IsolateUtil.killIsolate(isolate: _isolateSizes);
    IsolateUtil.killIsolate(isolate: _isolateColors);
    IsolateUtil.killIsolate(isolate: _isolateRangePrice);
  }

  bool checkMatchedColors(Color color) {
    final colors = colorsSelected.value;
    if (colors.isEmpty) return false;
    return colors.any((element) => element == color);
  }

  bool checkMatchedSizes(int id) {
    final sizes = sizesSelected.value;
    if (sizes.isEmpty) return false;
    return sizes.any((element) => element == id);
  }

  void onGoToBrandPage() {}

  @override
  void disposeModel() {
    rangePriceSelected.dispose();
    rangePrice.dispose();
    colorsSelected.dispose();
    colors.dispose();
    sizesSelected.dispose();
    sizes.dispose();
    categorySelected.dispose();
    brandsSelected.dispose();
    _killAllIsolates();
    super.disposeModel();
  }
}
