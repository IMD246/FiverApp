import 'package:fiver/core/base/base_service.dart';
import 'package:fiver/data/model/banner_model.dart';
import 'package:fiver/data/model/product_model.dart';
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
  Future<List<ProductModel>> getSaleProductList() async {
    return [
      ProductModel(
          name: "Evening Dress",
          brandName: "Dorothy Perkins",
          originPrice: 15,
          price: 12,
          urlImage:
              "https://images.squarespace-cdn.com/content/v1/528f8b33e4b01f2a315145b2/1473165174041-ELTK3U8JIOQRWBV330P7/static1.squarespace-13.jpg",
          salePercent: "-3%"),
      ProductModel(
          name: "Sport Dress",
          brandName: "Sitlly",
          originPrice: 22,
          price: 19,
          urlImage:
              "https://images.squarespace-cdn.com/content/v1/528f8b33e4b01f2a315145b2/1473165174041-ELTK3U8JIOQRWBV330P7/static1.squarespace-13.jpg",
          salePercent: "-5%"),
      ProductModel(
          name: "Evening Dres1s",
          brandName: "Dorothy Perkins1",
          originPrice: 14,
          price: 11,
          urlImage:
              "https://images.squarespace-cdn.com/content/v1/528f8b33e4b01f2a315145b2/1473165174041-ELTK3U8JIOQRWBV330P7/static1.squarespace-13.jpg",
          salePercent: "-7%"),
    ];
  }

  @override
  Future<List<ProductModel>> getNewProductList() async {
    return [
      ProductModel(
          name: "Evening Dress",
          brandName: "Dorothy Perkins",
          originPrice: 15,
          price: 12,
          urlImage:
              "https://images.squarespace-cdn.com/content/v1/528f8b33e4b01f2a315145b2/1473165174041-ELTK3U8JIOQRWBV330P7/static1.squarespace-13.jpg",
          salePercent: "-3%"),
      ProductModel(
          name: "Sport Dress",
          brandName: "Sitlly",
          originPrice: 22,
          price: 19,
          urlImage:
              "https://images.squarespace-cdn.com/content/v1/528f8b33e4b01f2a315145b2/1473165174041-ELTK3U8JIOQRWBV330P7/static1.squarespace-13.jpg",
          salePercent: "-5%"),
      ProductModel(
          name: "Evening Dres1s",
          brandName: "Dorothy Perkins1",
          originPrice: 14,
          price: 11,
          urlImage:
              "https://images.squarespace-cdn.com/content/v1/528f8b33e4b01f2a315145b2/1473165174041-ELTK3U8JIOQRWBV330P7/static1.squarespace-13.jpg",
          salePercent: "-7%"),
    ];
  }
}
