import 'package:fiver/core/extensions/ext_localization.dart';
import 'package:fiver/core/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:fiver/core/base/base_state.dart';
import 'package:fiver/core/res/theme/text_theme.dart';
import 'package:fiver/core/res/theme/theme_manager.dart';
import 'package:fiver/presentation/product_detail.dart/product_detail_model.dart';
import 'package:fiver/presentation/widgets/common_appbar.dart';
import 'package:fiver/presentation/widgets/custom_button.dart';
import 'package:shimmer/shimmer.dart';

import 'components/components.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({
    super.key,
    required this.id,
    required this.name,
  });
  final String id;
  final String name;
  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState
    extends BaseState<ProductDetailModel, ProductDetailPage> {
  @override
  void initState() {
    super.initState();
    model.init(
      id: widget.id,
      name: widget.name,
    );
  }

  @override
  Widget buildContent() {
    return WillPopScope(
      onWillPop: model.onBack,
      child: super.buildContent(),
    );
  }

  @override
  Widget buildContentView(BuildContext context, ProductDetailModel model) {
    return SingleChildScrollView(
      child: Column(
        children: [
          BannerProductDetail(
            model: model,
          ),
          SizedBox(height: 12.w),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizeBlackButtons(model: model),
                SizedBox(height: 22.w),
                _namePrice(model),
                SizedBox(height: 4.w),
                ValueListenableBuilder(
                  valueListenable: model.loadingProductDetail,
                  builder: (context, loadingProductDetail, child) {
                    if (loadingProductDetail) {
                      return Shimmer.fromColors(
                        baseColor:
                            getColor().themeColorAAAAAAA.withOpacity(0.4),
                        highlightColor:
                            getColor().themeColorAAAAAAA.withOpacity(0.2),
                        child: Container(
                          height: 11.w,
                          width: 80.w,
                          color: Colors.white,
                        ),
                      );
                    }
                    return Text(
                      "Short black dress",
                      style: text11.copyWith(
                        color: getColor().themeColor222222White,
                      ),
                    );
                  },
                ),
                SizedBox(height: 8.w),
                _ratingProduct(),
                SizedBox(height: 20.w),
                _description(),
                SizedBox(height: 12.w),
                RelatedProductListCard(model: model),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _description() {
    return ValueListenableBuilder(
      valueListenable: model.loadingProductDetail,
      builder: (context, loadingProductDetail, child) {
        if (loadingProductDetail) {
          return Column(
            children: List.generate(
              4,
              (index) => Shimmer.fromColors(
                baseColor: getColor().themeColorAAAAAAA.withOpacity(0.4),
                highlightColor: getColor().themeColorAAAAAAA.withOpacity(0.2),
                child: Container(
                  width: double.infinity,
                  height: 14.w,
                  margin: EdgeInsets.only(bottom: 8.w),
                  color: Colors.white,
                ),
              ),
            ),
          );
        }
        return Text(
          "Short dress in soft cotton jersey with decorative buttons down the front and a wide, frill-trimmed square neckline with concealed elastication. Elasticated seam under the bust and short puff sleeves with a small frill trim.",
          style: text14.copyWith(
            color: getColor().themeColor222222White,
          ),
        );
      },
    );
  }

  Widget _namePrice(ProductDetailModel model) {
    return ValueListenableBuilder(
      valueListenable: model.loadingProductDetail,
      builder: (context, loadingProductDetail, child) {
        if (loadingProductDetail) {
          return Shimmer.fromColors(
            baseColor: getColor().themeColorAAAAAAA.withOpacity(0.4),
            highlightColor: getColor().themeColorAAAAAAA.withOpacity(0.2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 12.w,
                  width: 40.w,
                  color: Colors.white,
                ),
                Container(
                  height: 12.w,
                  width: 40.w,
                  color: Colors.white,
                ),
              ],
            ),
          );
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "H&M",
              style: text24.bold.copyWith(
                color: getColor().themeColor222222White,
              ),
            ),
            Text(
              "\$19.99",
              style: text24.bold.copyWith(
                color: getColor().themeColor222222White,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _ratingProduct() {
    return ValueListenableBuilder(
      valueListenable: model.loadingProductDetail,
      builder: (context, value, child) {
        if (value) {
          return Shimmer.fromColors(
            baseColor: getColor().themeColorAAAAAAA.withOpacity(0.4),
            highlightColor: getColor().themeColorAAAAAAA.withOpacity(0.2),
            child: Container(
              height: 16.w,
              width: 120.w,
              color: Colors.white,
            ),
          );
        }
        return InkWell(
          onTap: () => model.onToRatingAndReview(widget.id),
          child: Row(
            children: [
              RatingBar.builder(
                itemBuilder: (context, index) {
                  return const Icon(
                    Icons.star,
                    color: Colors.amber,
                  );
                },
                ignoreGestures: true,
                onRatingUpdate: (value) {},
                maxRating: 5,
                minRating: 0,
                initialRating: 3.5,
                itemSize: 16.w,
              ),
              SizedBox(width: 4.w),
              Text(
                "(10)",
                style: text10.copyWith(
                  color: getColor().themeColorBlackWhite,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  CommonAppbar? get appbar => CommonAppbar(
        title: widget.name,
        action: model.onBack,
        trailing: [
          InkWell(
            onTap: () => model.onShare(context),
            child: Icon(
              Icons.share,
              color: getColor().themeColor222222White,
            ),
          ),
        ],
      );

  @override
  Widget? get floatingActionButton => Padding(
        padding: EdgeInsets.only(left: 16.w, bottom: 8.w, right: 16.w),
        child: CustomButton(
          text: context.loc.add_to_cart.toUpperCase(),
          onPressed: model.addToCart,
          backgroundIsEnable: colordb3022,
          textStyleEnable: text14.copyWith(
            color: colorWhite,
          ),
          isEnable: model.isEnableAddToCart,
        ),
      );
}
