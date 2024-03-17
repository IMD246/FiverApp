import 'package:flutter/material.dart';

import '../../core/base/base_model.dart';
import '../../core/di/locator_service.dart';
import '../../core/routes/app_router.dart';
import '../../core/utils/util.dart';
import '../../data/model/brand_model.dart';
import '../../data/model/category_model.dart';
import '../../data/model/filter_ui_model.dart';
import '../../data/model/size_model.dart';
import '../../domain/repositories/common_repository.dart';

class FilterModel extends BaseModel {
  final _commonRepo = locator<CommonRepository>();

  ValueNotifier<RangeValues> rangePriceSelected =
      ValueNotifier(const RangeValues(0, 0));

  ValueNotifier<RangeValues?> rangePrice = ValueNotifier(null);

  ValueNotifier<List<Color>> colorsSelected = ValueNotifier([]);

  ValueNotifier<List<Color>> colors = ValueNotifier([]);

  ValueNotifier<List<int>> sizesSelected = ValueNotifier([]);

  ValueNotifier<List<SizeModel>> sizes = ValueNotifier([]);

  ValueNotifier<CategoryModel?> categorySelected = ValueNotifier(null);

  ValueNotifier<List<MBrand>> brandsSelected = ValueNotifier([]);

  ValueNotifier<bool> isReadyOnApply = ValueNotifier(false);

  void init(FilterUIModel? filterModel) async {
    _updateSizes(filterModel?.sizes ?? []);
    _updateColors(filterModel?.colors ?? <Color>[]);
    _updateCategory(filterModel?.category);
    _updateBrands(filterModel?.brands ?? []);
    updateRangeValues(
      RangeValues(
        filterModel?.minPrice ?? 0,
        filterModel?.maxPrice ?? 0,
      ),
    );
    Future.wait([
      _getSizes(),
      _getColors(),
      _getRangePrice(),
    ]).whenComplete(() {
      if (!isDisposed) {
        setValueNotifier(isReadyOnApply, true);
      }
    });
  }

  Future<void> _getSizes() async {
    try {
      final getSizes = await _commonRepo.getSizes();
      setValueNotifier(sizes, getSizes);
    } catch (e) {
      setValueNotifier(sizes, <SizeModel>[]);
    }
  }

  Future<void> _getColors() async {
    try {
      final getColors = await _commonRepo.getColors();
      setValueNotifier(colors, getColors);
    } catch (e) {
      setValueNotifier(colors, <SizeModel>[]);
    }
  }

  Future<void> _getRangePrice() async {
    try {
      final getRangePrice = await _commonRepo.getRangePrice();
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
      setValueNotifier(
        sizesSelected,
        [...sizes],
      );
    }
  }

  void updateSize(int sizeId) {
    final sizes = sizesSelected.value;
    if (sizes.any((element) => element == sizeId)) {
      sizes.remove(sizeId);
    } else {
      sizes.add(sizeId);
    }
    setValueNotifier(sizesSelected, [...sizes]);
  }

  void _updateCategory(CategoryModel? category) {
    if (categorySelected.value?.id == category?.id) return;
    setValueNotifier(categorySelected, category);
  }

  void _updateBrands(List<MBrand> brands) {
    if (brands.isEmpty) {
      setValueNotifier(brandsSelected, <MBrand>[]);
    } else {
      setValueNotifier(brandsSelected, [...brands]);
    }
  }

  void _updateColors(List<Color> colors) {
    if (colors.isEmpty) {
      setValueNotifier(colorsSelected, <Color>[]);
    } else {
      setValueNotifier(colorsSelected, [
        ...colors,
      ]);
    }
  }

  void updateColorsSelected(Color color) {
    final colors = colorsSelected.value;
    if (colors.any((element) => element == color)) {
      colorsSelected.value.remove(color);
    } else {
      colorsSelected.value.add(color);
    }
    setValueNotifier(colorsSelected, [...colors]);
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

  void onGoToBrandPage() async {
    await AppRouter.router
        .push(
      AppRouter.brandPath,
      extra: brandsSelected.value,
    )
        .then(
      (value) {
        if (value != null) {
          _updateBrands(value as List<MBrand>);
        }
      },
    );
  }

  void clearAll() {
    _updateColors([]);
    _updateSizes([]);
    updateRangeValues(rangePrice.value ?? const RangeValues(0, 0));
    _updateBrands([]);
    notifyListeners();
  }

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
    isReadyOnApply.dispose();
    super.disposeModel();
  }
}
