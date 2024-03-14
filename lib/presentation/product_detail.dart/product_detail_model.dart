import '../../core/base/base_model.dart';
import '../../core/routes/app_router.dart';
import '../../core/utils/dynamic_link_util.dart';
import '../../core/utils/media_util.dart';
import '../../core/utils/util.dart';
import '../../data/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:share_plus/share_plus.dart';

class ProductDetailModel extends BaseModel {
  late final String id;
  late final String name;

  final List<String> images = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYscfUBUbqwGd_DHVhG-ZjCOD7MUpxp4uhNe7toUg4ug&s",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYscfUBUbqwGd_DHVhG-ZjCOD7MUpxp4uhNe7toUg4ug&s",
  ];

  final ValueNotifier<bool> loadingRelatedProducts = ValueNotifier(true);

  final ValueNotifier<bool> loadingProductDetail = ValueNotifier(true);

  final ValueNotifier<bool> isEnableAddToCart = ValueNotifier(false);

  final ScrollController scrollController = ScrollController();

  ValueNotifier<double> opacity = ValueNotifier(1);

  final ValueNotifier<List<ProductModel>> relatedProducts = ValueNotifier(
    [
      ProductModel(
        name: "Evening Dress",
        brandName: "Dorothy Perkins",
        originPrice: 15,
        price: 12,
        urlImage:
            "https://images.squarespace-cdn.com/content/v1/528f8b33e4b01f2a315145b2/1473165174041-ELTK3U8JIOQRWBV330P7/static1.squarespace-13.jpg",
        salePercent: 5,
        isNew: false,
      ),
      ProductModel(
        name: "Sport Dress",
        brandName: "Sitlly",
        originPrice: 22,
        price: 19,
        urlImage:
            "https://images.squarespace-cdn.com/content/v1/528f8b33e4b01f2a315145b2/1473165174041-ELTK3U8JIOQRWBV330P7/static1.squarespace-13.jpg",
        salePercent: 5,
        isNew: true,
      ),
      ProductModel(
        isNew: false,
        name: "Evening Dres1s",
        brandName: "Dorothy Perkins1",
        originPrice: 14,
        price: 11,
        urlImage:
            "https://images.squarespace-cdn.com/content/v1/528f8b33e4b01f2a315145b2/1473165174041-ELTK3U8JIOQRWBV330P7/static1.squarespace-13.jpg",
        salePercent: 0,
      ),
      ProductModel(
        isNew: false,
        name: "Evening Dress",
        brandName: "Dorothy Perkins",
        originPrice: 15,
        price: 12,
        urlImage:
            "https://images.squarespace-cdn.com/content/v1/528f8b33e4b01f2a315145b2/1473165174041-ELTK3U8JIOQRWBV330P7/static1.squarespace-13.jpg",
        salePercent: 0,
      ),
      ProductModel(
        isNew: false,
        name: "Sport Dress",
        brandName: "Sitlly",
        originPrice: 22,
        price: 19,
        urlImage:
            "https://images.squarespace-cdn.com/content/v1/528f8b33e4b01f2a315145b2/1473165174041-ELTK3U8JIOQRWBV330P7/static1.squarespace-13.jpg",
        salePercent: 5,
      ),
      ProductModel(
        isNew: false,
        name: "Evening Dres1s",
        brandName: "Dorothy Perkins1",
        originPrice: 14,
        price: 11,
        urlImage:
            "https://images.squarespace-cdn.com/content/v1/528f8b33e4b01f2a315145b2/1473165174041-ELTK3U8JIOQRWBV330P7/static1.squarespace-13.jpg",
        salePercent: 5,
      ),
    ],
  );

  void init({
    required String id,
    required String name,
  }) async {
    this.id = id;
    this.name = name;
    scrollController.addListener(_scrollReviewListener);
    Future.delayed(
      const Duration(seconds: 4),
      () {
        if (!isDisposed) {
          setValueNotifier(loadingRelatedProducts, false);
          setValueNotifier(loadingProductDetail, false);
          _updateEnableAddToCart();
        }
      },
    );
  }

  void _scrollReviewListener() {
    final isScrollUp = scrollController.position.userScrollDirection ==
        ScrollDirection.forward;
    if (!isScrollUp) {
      if (opacity.value > 0.05) {
        setValueNotifier(opacity, opacity.value -= 0.01);
      }
      else
      {
        setValueNotifier(opacity, 0.05);
      }
    } else {
      if (opacity.value < 0.9) {
        setValueNotifier(opacity, opacity.value += 0.01);
      }
      else
      {
        setValueNotifier(opacity, 1.0);
      }
    }
    if (scrollController.position.atEdge) {
      bool isTop = scrollController.position.pixels == 0;
      if (isTop) {
        setValueNotifier(opacity, 1.0);
      } else {
        setValueNotifier(opacity, 0.05);
      }
    }
  }

  void onToRatingAndReview(String id) {
    AppRouter.router.push(
      AppRouter.ratingAndReviewPath,
      extra: id,
    );
  }

  @override
  void disposeModel() {
    relatedProducts.dispose();
    loadingRelatedProducts.dispose();
    loadingProductDetail.dispose();
    scrollController.removeListener(_scrollReviewListener);
    scrollController.dispose();
    super.disposeModel();
  }

  void onToProductDetail(ProductModel product) {
    AppRouter.router.push(
      Uri(
        path: AppRouter.productDetailPath,
        queryParameters: {
          "id": product.id,
          "name": product.name,
        },
      ).toString(),
    );
  }

  void _updateEnableAddToCart() {
    setValueNotifier(
      isEnableAddToCart,
      !loadingRelatedProducts.value && !loadingProductDetail.value,
    );
  }

  void addToCart() {}

  void onShare(BuildContext context) async {
    try {
      final file = await MediaUtils.urlImageToFile(
        url: images.first,
      );
      final uri = await createDynamicLink(
        path: "/product-detail",
        queryParameters: {
          "id": id,
          "name": name,
        },
      );
      await Share.shareXFiles(
        [
          XFile(file.path),
        ],
        text: "${uri.toString()} \n $name",
      );
    } catch (e) {
      showErrorException(e);
    }
  }

  bool onBack(bool didPop) {
    if (AppRouter.router.canPop()) {
      AppRouter.router.pop();
      return true;
    } else {
      AppRouter.router.go(AppRouter.mainPath);
      return false;
    }
  }
}
