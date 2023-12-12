import 'package:fiver/core/base/base_service.dart';
import 'package:fiver/data/model/banner_model.dart';
import 'package:fiver/data/model/gender_model.dart';
import 'package:fiver/data/model/sort_by_model.dart';
import 'package:fiver/domain/repositories/common_repository.dart';

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
      GenderModel(gender: "Women"),
      GenderModel(gender: "Men"),
      GenderModel(gender: "Kids"),
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
}
