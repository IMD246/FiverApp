import 'dart:ui';

import '../../../core/di/locator_service.dart';
import '../../../domain/repositories/common_repository.dart';
import '../../data_source/local/isar_db.dart';
import '../../data_source/local/preferences.dart';
import '../../model/banner_model.dart';
import '../../model/brand_model.dart';
import '../../model/gender_model.dart';
import '../../model/size_model.dart';
import '../../model/sort_by_model.dart';

class LocalCommonRepository extends CommonRepository {
  final _pref = locator<Preferences>();
  final _isarDb = locator<IsarDb>();

  @override
  Future<List<BannerModel>> getBannerList() async {
    return [];
  }

  @override
  Future<List<Color>> getColors() async {
    return _pref.getColors();
  }

  Future<void> saveColors(List<Color> colors) async {
    await _pref.saveColors(colors);
  }

  @override
  Future<List<GenderModel>> getFilterGenders() async {
    return [];
  }

  @override
  Future<List<GenderModel>> getGenders() async {
    return await _isarDb.getGenders();
  }

  Future<void> saveGenders(List<GenderModel> genders) async {
    await _isarDb.saveGenders(genders);
  }

  @override
  Future<List<double>> getRangePrice() async {
    return _pref.getPriceRange();
  }

  Future<void> savePriceRange(List<double> priceRange) async {
    await _pref.savePriceRange(priceRange);
  }

  @override
  Future<List<SizeModel>> getSizes() async {
    return await _isarDb.getSizes();
  }

  Future<void> saveSizes(List<SizeModel> sizes) async {
    await _isarDb.saveSizes(sizes);
  }

  @override
  Future<List<SortByModel>> getSortByList() async {
    return await _isarDb.getSortByList();
  }

  Future<void> saveSortByList(List<SortByModel> sortByList) async {
    await _isarDb.saveSortByList(sortByList);
  }

  @override
  Future<List<MBrand>> getBrands({
    String? query,
    required int page,
    required int pageSize,
  }) async {
    return [];
  }
}
