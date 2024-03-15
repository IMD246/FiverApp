import 'dart:convert';
import 'dart:ui';

import 'package:fiver/core/constant/constants.dart';
import 'package:fiver/core/di/locator_service.dart';
import 'package:fiver/core/res/colors.dart';
import 'package:fiver/core/utils/collection_util.dart';
import 'package:fiver/data/model/banner_model.dart';
import 'package:fiver/data/model/brand_model.dart';
import 'package:fiver/data/model/gender_model.dart';
import 'package:fiver/data/model/size_model.dart';
import 'package:fiver/data/model/sort_by_model.dart';
import 'package:fiver/data/repositories/local/local_common_repository.dart';
import 'package:fiver/domain/repositories/common_repository.dart';

class TestRemoteCommonRepository implements CommonRepository {
  final _localCommonRepository = locator<CommonRepository>(
    instanceName: Constants.instanceLocalCommonRepository,
  ) as LocalCommonRepository;

  @override
  Future<List<BannerModel>> getBannerList({required String isHome}) async {
    return [
      BannerModel(
        id: 1,
        bannerLink: "",
        image:
            "https://static.vecteezy.com/system/resources/thumbnails/005/715/816/small/banner-abstract-background-board-for-text-and-message-design-modern-free-vector.jpg",
        name: "b1",
      ),
      BannerModel(
        id: 2,
        bannerLink: "",
        image:
            "https://static.vecteezy.com/system/resources/thumbnails/005/715/816/small/banner-abstract-background-board-for-text-and-message-design-modern-free-vector.jpg",
        name: "b2",
      ),
    ];
  }

  @override
  Future<List<GenderModel>> getGenders() async {
    final genders = [
      GenderModel(id: 2, gender: "Women"),
      GenderModel(id: 3, gender: "Men"),
      GenderModel(id: 4, gender: "Kids"),
    ];

    final dataEncoded =
        jsonEncode(genders.map((i) => i.toJson()).toList()).toString();

    final dataDecoded = jsonDecode(dataEncoded) as List;

    final convertedGenders = List<GenderModel>.from(
        dataDecoded.map((e) => GenderModel.fromMap(jsonDecode(e))).toList());

    await _localCommonRepository.saveGenders(convertedGenders);

    return convertedGenders;
  }

  @override
  Future<List<GenderModel>> getFilterGenders() async {
    return [
      GenderModel(id: 1, gender: "All"),
      GenderModel(id: 2, gender: "Women"),
      GenderModel(id: 3, gender: "Men"),
      GenderModel(id: 4, gender: "Kids"),
    ];
  }

  @override
  Future<List<SortByModel>> getSortByList() async {
    final sortByList = [
      SortByModel(id: 1, name: "Popular"),
      SortByModel(id: 2, name: "Newest"),
      SortByModel(id: 3, name: "Customer review"),
      SortByModel(id: 4, name: "Price: lowest to high"),
      SortByModel(id: 5, name: "Price: highest to low"),
    ];

    final dataEncoded =
        jsonEncode(sortByList.map((i) => i.toJson()).toList()).toString();

    final dataDecoded = jsonDecode(dataEncoded) as List;

    final convertedSortByList = List<SortByModel>.from(
        dataDecoded.map((e) => SortByModel.fromMap(jsonDecode(e))).toList());

    await _localCommonRepository.saveSortByList(sortByList);

    return convertedSortByList;
  }

  @override
  Future<List<SizeModel>> getSizes() async {
    final sizes = [
      SizeModel(id: 1, sizeName: "XS"),
      SizeModel(id: 2, sizeName: "S"),
      SizeModel(id: 3, sizeName: "M"),
      SizeModel(id: 4, sizeName: "L"),
      SizeModel(id: 5, sizeName: "XL"),
    ];

    final dataEncoded =
        jsonEncode(sizes.map((i) => i.toJson()).toList()).toString();

    final dataDecoded = jsonDecode(dataEncoded) as List;

    final convertedSizes = List<SizeModel>.from(
        dataDecoded.map((e) => SizeModel.fromMap(jsonDecode(e))).toList());

    await _localCommonRepository.saveSizes(convertedSizes);

    return convertedSizes;
  }

  @override
  Future<List<Color>> getColors() async {
    final colors = [
      color020202,
      colorF6F6F6,
      colorF48117,
      colorBEA9A9,
      color91BA4F,
      color2CB1B1
    ];

    final dataEncoded =
        jsonEncode(colors.map((i) => i.value.toString()).toList()).toString();

    final dataDecoded = jsonDecode(dataEncoded) as List;

    final convertedColors =
        List<Color>.from(dataDecoded.map((e) => Color(jsonDecode(e))).toList());

    await _localCommonRepository.saveColors(convertedColors);

    return convertedColors;
  }

  @override
  Future<List<double>> getRangePrice() async {
    final List<double> rangePrice = [0, 135];

    final dataEncoded =
        jsonEncode(rangePrice.map((i) => i.toString()).toList()).toString();

    final dataDecoded = jsonDecode(dataEncoded) as List;

    final convertedRangePrices =
        List<double>.from(dataDecoded.map((e) => jsonDecode(e)).toList());

    await _localCommonRepository.savePriceRange(rangePrice);

    return convertedRangePrices;
  }

  @override
  Future<List<MBrand>> getBrands({
    String? query,
    required int page,
    required int pageSize,
  }) async {
    final brands = [
      MBrand(
        id: 1,
        name: "adidas",
      ),
      MBrand(
        id: 2,
        name: "adidas Originals",
      ),
      MBrand(
        id: 3,
        name: "Blend",
      ),
      MBrand(
        id: 4,
        name: "Boutique Moschino",
      ),
      MBrand(
        id: 5,
        name: "Champion",
      ),
      MBrand(
        id: 6,
        name: "Diesel",
      ),
      MBrand(
        id: 7,
        name: "Jack & Jones",
      ),
      MBrand(
        id: 8,
        name: "Naf Naf",
      ),
      MBrand(
        id: 9,
        name: "Red Valentino",
      ),
      MBrand(
        id: 10,
        name: "s.Oliver",
      ),
    ];
    if (query!.isNullOrEmpty) {
      return brands;
    }
    List<MBrand> brandsFiltered = [];
    for (var brand in brands) {
      for (var i = 0; i < brand.name.length; i++) {
        final charName = brand.name[i].toLowerCase();
        if (query.contains(charName)) {
          brandsFiltered.add(brand);
          break;
        }
      }
    }
    return brandsFiltered;
  }
}
