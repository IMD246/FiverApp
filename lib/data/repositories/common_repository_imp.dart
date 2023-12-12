import '../../core/base/base_service.dart';
import '../model/banner_model.dart';
import '../model/gender_model.dart';
import '../model/size_model.dart';
import '../model/sort_by_model.dart';
import '../../domain/repositories/common_repository.dart';
import 'package:flutter/material.dart';

import '../../core/res/colors.dart';

class CommonRepositoryImp extends BaseSerivce implements CommonRepository {
  @override
  Future<List<BannerModel>> getBannerList() async {
    return [
      BannerModel(
        urlImage:
            "https://static.vecteezy.com/system/resources/thumbnails/005/715/816/small/banner-abstract-background-board-for-text-and-message-design-modern-free-vector.jpg",
        content: "Street clothes",
      ),
      BannerModel(
        urlImage:
            "https://t3.ftcdn.net/jpg/02/68/48/86/360_F_268488616_wcoB2JnGbOD2u3bpn2GPmu0KJQ4Ah66T.jpg",
        content: "Street clothes2",
      ),
    ];
  }

  @override
  Future<List<GenderModel>> getGenders() async {
    return [
      GenderModel(id: 2,gender: "Women"),
      GenderModel(id: 3,gender: "Men"),
      GenderModel(id: 4,gender: "Kids"),
    ];
  }

  @override
  Future<List<GenderModel>> getFilterGenders() async {
    return [
      GenderModel(id: 1,gender: "All"),
      GenderModel(id: 2, gender: "Women"),
      GenderModel(id: 3, gender: "Men"),
      GenderModel(id: 4, gender: "Kids"),
    ];
  }

  @override
  Future<List<SortByModel>> getSortByList() async {
    return [
      SortByModel(name: "Popular"),
      SortByModel(name: "Newest"),
      SortByModel(name: "Customer review"),
      SortByModel(name: "Price: lowest to high"),
      SortByModel(name: "Price: highest to low"),
    ];
  }

  @override
  Future<List<SizeModel>> getSizeList() async {
    return [
      SizeModel(id: 1,sizeName: "XS"),
      SizeModel(id: 2,sizeName: "S"),
      SizeModel(id: 3,sizeName: "M"),
      SizeModel(id: 4,sizeName: "L"),
      SizeModel(id: 5,sizeName: "XL"),
    ];
  }

  @override
  Future<List<Color>> getColorList() async {
    return [
      color020202,
      colorF6F6F6,
      colorF48117,
      colorBEA9A9,
      color91BA4F,
      color2CB1B1
    ];
  }

  @override
  Future<List<double>> getRangePrice() async {
    return [
      0,
      135,
    ];
  }
}
