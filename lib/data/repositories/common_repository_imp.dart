import 'package:flutter/material.dart';

import '../../core/base/base_service.dart';
import '../../core/constant/constants.dart';
import '../../core/di/locator_service.dart';
import '../../domain/repositories/common_repository.dart';
import '../model/banner_model.dart';
import '../model/gender_model.dart';
import '../model/size_model.dart';
import '../model/sort_by_model.dart';
import 'local/local_common_repository.dart';
import 'remote/remote_common_repository.dart';

class CommonRepositoryImp extends BaseSerivce implements CommonRepository {
  final _localCommonRepository = locator<CommonRepository>(
          instanceName: Constants.instanceLocalCommonRepository)
      as LocalCommonRepository;

  final _remoteCommonRepository = locator<CommonRepository>(
          instanceName: Constants.instanceRemoteCommonRepository)
      as RemoteCommonRepository;
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
    List<GenderModel> genders = await _localCommonRepository.getGenders();
    if (genders.isNotEmpty) {
      return genders;
    }
    return await _remoteCommonRepository.getGenders();
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
    return [
      SortByModel(name: "Popular"),
      SortByModel(name: "Newest"),
      SortByModel(name: "Customer review"),
      SortByModel(name: "Price: lowest to high"),
      SortByModel(name: "Price: highest to low"),
    ];
  }

  @override
  Future<List<SizeModel>> getSizes() async {
    List<SizeModel> sizes = await _localCommonRepository.getSizes();
    if (sizes.isNotEmpty) {
      return sizes;
    }
    return await _remoteCommonRepository.getSizes();
  }

  @override
  Future<List<Color>> getColors() async {
    final colors = await _localCommonRepository.getColors();
    if (colors.isNotEmpty) {
      return colors;
    }
    return await _remoteCommonRepository.getColors();
  }

  @override
  Future<List<double>> getRangePrice() async {
    final rangePrice = await _localCommonRepository.getRangePrice();
    if (rangePrice.isNotEmpty) {
      return rangePrice;
    }
    return await _remoteCommonRepository.getRangePrice();
  }
}
