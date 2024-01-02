import 'dart:ui';

import 'package:fiver/core/base/base_service.dart';
import 'package:fiver/data/model/rating_model.dart';

import '../../../core/constant/constants.dart';
import '../../../core/di/locator_service.dart';
import '../../../core/res/colors.dart';
import '../../../core/utils/util.dart';
import '../../../domain/repositories/common_repository.dart';
import '../../data_source/remote/network/network_url.dart';
import '../../model/banner_model.dart';
import '../../model/brand_model.dart';
import '../../model/gender_model.dart';
import '../../model/size_model.dart';
import '../../model/sort_by_model.dart';
import '../local/local_common_repository.dart';

class RemoteCommonRepository extends BaseSerivce implements CommonRepository {
  final _localCommonRepository = locator<CommonRepository>(
    instanceName: Constants.instanceLocalCommonRepository,
  ) as LocalCommonRepository;

  @override
  Future<List<BannerModel>> getBannerList({required String isHome}) async {
    final response = await get(
      GET_BANNER,
      params: {
        "is_home": isHome,
      },
    );
    return List.from(
      (response.data as List).map((e) => BannerModel.fromJson(e)).toList(),
    );
  }

  @override
  Future<List<GenderModel>> getGenders() async {
    final genders = [
      GenderModel(id: 2, gender: "Women"),
      GenderModel(id: 3, gender: "Men"),
      GenderModel(id: 4, gender: "Kids"),
    ];
    await _localCommonRepository.saveGenders(genders);
    return genders;
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
    await _localCommonRepository.saveSortByList(sortByList);
    return sortByList;
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
    await _localCommonRepository.saveSizes(sizes);
    return sizes;
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
    await _localCommonRepository.saveColors(colors);
    return colors;
  }

  @override
  Future<List<double>> getRangePrice() async {
    final List<double> rangePrice = [0, 135];
    await _localCommonRepository.savePriceRange(rangePrice);
    return rangePrice;
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
    if (query.isNullOrEmpty) {
      return brands;
    }
    List<MBrand> brandsFiltered = [];
    for (var brand in brands) {
      for (var i = 0; i < brand.name.length; i++) {
        final charName = brand.name[i].toLowerCase();
        if (query!.contains(charName)) {
          brandsFiltered.add(brand);
          break;
        }
      }
    }
    return brandsFiltered;
  }

  @override
  Future<RatingModel> getRating() async {
    final rating = RatingModel(
      percentRatings: 4.3,
      ratings: 23,
      starList: [
        StarModel(starNumber: 5, starRating: 12),
        StarModel(starNumber: 4, starRating: 5),
        StarModel(starNumber: 3, starRating: 4),
        StarModel(starNumber: 2, starRating: 2),
        StarModel(starNumber: 1, starRating: 0),
      ],
    );

    return rating;
  }
}
