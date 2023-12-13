import '../../data/model/banner_model.dart';
import '../../data/model/gender_model.dart';
import '../../data/model/size_model.dart';
import 'package:flutter/material.dart';

import '../../data/model/sort_by_model.dart';

abstract class CommonRepository {
  Future<List<BannerModel>> getBannerList();
  Future<List<GenderModel>> getGenders();
  Future<List<SortByModel>> getSortByList();
  Future<List<SizeModel>> getSizes();
  Future<List<Color>> getColors();
  Future<List<double>> getRangePrice();
  Future<List<GenderModel>> getFilterGenders();
}
