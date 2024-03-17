import 'package:flutter/material.dart';

import '../../core/base/base_list_model.dart';
import '../../core/di/locator_service.dart';
import '../../core/routes/app_router.dart';
import '../../core/utils/text_field_editing_controller_custom.dart';
import '../../core/utils/util.dart';
import '../../data/model/brand_model.dart';
import '../../domain/repositories/common_repository.dart';

class BrandModel extends BaseListModel<MBrand> {
  final _commonRepo = locator<CommonRepository>();
  final searchCtr = TextEditingControllerCustom();

  ValueNotifier<List<MBrand>> brands = ValueNotifier([]);

  ValueNotifier<List<MBrand>> brandsSelected = ValueNotifier([]);

  ValueNotifier<bool> isReadyOnApply = ValueNotifier(false);

  ValueNotifier<bool> isTaping = ValueNotifier(false);

  void init(List<MBrand> brands) async {
    _updateBrandsSelected(brands);
    searchCtr.listener(
      action: () {
        setValueNotifier(isTaping, true);
        refresh().whenComplete(() {
          setValueNotifier(isTaping, false);
        });
      },
    );
  }

  void _updateBrandsSelected(List<MBrand> brands) {
    if (brands.isEmpty) {
      setValueNotifier(brandsSelected, <MBrand>[]);
    } else {
      setValueNotifier(brandsSelected, brands);
    }
  }

  void updateBrand(MBrand brand) {
    final brands = brandsSelected.value;
    if (brands.any((element) => element.id == brand.id)) {
      brandsSelected.value.remove(brand);
    } else {
      brandsSelected.value.add(brand);
    }
    setValueNotifier(brandsSelected, [...brands]);
  }

  void onBack({bool newUpdate = true}) {
    unFocus();
    AppRouter.router.pop(
      newUpdate ? brandsSelected.value : null,
    );
  }

  bool checkMatchedBrand(MBrand brand) {
    final brands = brandsSelected.value;
    if (brands.isEmpty) return false;
    return brands.any((element) => element.id == brand.id);
  }

  void onApply() {
    onBack();
  }

  void onDiscard() {
    onBack(newUpdate: false);
  }

  @override
  void disposeModel() {
    searchCtr.dispose();
    brands.dispose();
    brandsSelected.dispose();
    isReadyOnApply.dispose();
    isTaping.dispose();
    super.disposeModel();
  }

  @override
  Future<List<MBrand>?> getData({params, bool? isClear}) async {
    try {
      return await _commonRepo.getBrands(
        query: searchCtr.text,
        page: page,
        pageSize: pageSize,
      );
    } catch (e) {
      return [];
    }
  }

  @override
  void onModelReady() {
    super.onModelReady();
    setValueNotifier(isReadyOnApply, true);
    _handleBrandSelectedWithResultBrands();
  }

  void _handleBrandSelectedWithResultBrands() {
    if (items.isEmpty) {
      _updateBrandsSelected([]);
      return;
    }
    final List<MBrand> brandsMatched = [];
    final List<MBrand> brandsSelected = this.brandsSelected.value;
    for (var item in items) {
      if (brandsSelected.any((element) => element.id == item.id)) {
        brandsMatched.add(item);
      }
    }
    _updateBrandsSelected(brandsMatched);
  }
}