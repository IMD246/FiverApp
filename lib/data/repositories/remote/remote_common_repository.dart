import 'dart:ui';

import '../../../core/utils/util.dart';
import '../../model/brand_model.dart';

import '../../../core/constant/constants.dart';
import '../../../core/di/locator_service.dart';
import '../../model/banner_model.dart';
import '../../model/gender_model.dart';
import '../../model/size_model.dart';
import '../../model/sort_by_model.dart';
import '../local/local_common_repository.dart';
import '../../../domain/repositories/common_repository.dart';

import '../../../core/res/colors.dart';

class RemoteCommonRepository implements CommonRepository {
  final _localCommonRepository = locator<CommonRepository>(
    instanceName: Constants.instanceLocalCommonRepository,
  ) as LocalCommonRepository;

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
}
