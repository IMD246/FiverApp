import 'package:fiver/data/model/banner_model.dart';
import 'package:fiver/data/model/gender_model.dart';

import '../../data/model/sort_by_model.dart';

abstract class CommonRepository {
  Future<List<BannerModel>> getBannerList();
  Future<List<GenderModel>> getGenders();
  Future<List<SortByModel>> getSortByList();

}
