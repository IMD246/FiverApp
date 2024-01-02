import 'package:flutter/material.dart';

import '../../data/model/banner_model.dart';
import '../../data/model/brand_model.dart';
import '../../data/model/gender_model.dart';
import '../../data/model/rating_model.dart';
import '../../data/model/size_model.dart';
import '../../data/model/sort_by_model.dart';

abstract class CommonRepository {
  Future<List<BannerModel>> getBannerList({required String isHome});

  Future<List<GenderModel>> getGenders();

  Future<List<SortByModel>> getSortByList();

  Future<List<SizeModel>> getSizes();

  Future<List<Color>> getColors();

  Future<List<double>> getRangePrice();

  Future<List<GenderModel>> getFilterGenders();

  Future<List<MBrand>> getBrands({
    String? query,
    required int page,
    required int pageSize,
  });

  Future<RatingModel> getRating();
}
