import '../../../core/extensions/ext_localization.dart';
import '../product_detail_model.dart';
import '../../widgets/add_to_favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/res/theme/text_theme.dart';
import '../../../../core/res/theme/theme_manager.dart';
import '../../../../data/model/product_model.dart';
import '../../widgets/extra_product_display_widget.dart';
import '../../widgets/price_display_widget.dart';

class RelatedProductListCard extends StatelessWidget {
  const RelatedProductListCard({
    super.key,
    required this.model,
  });
  final ProductDetailModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueListenableBuilder(
          valueListenable: model.loadingRelatedProducts,
          builder: (context, loadingRelatedProducts, child) {
            if (loadingRelatedProducts) {
              return const SizedBox.shrink();
            }
            return ValueListenableBuilder(
              valueListenable: model.relatedProducts,
              builder: (context, relatedProducts, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.loc.you_can_also_like_this,
                      style: text18.bold.copyWith(
                        color: getColor().themeColor222222White,
                      ),
                    ),
                    Text(
                      "${relatedProducts.length} ${context.loc.items.toLowerCase()}",
                      style: text11.copyWith(
                        color: getColor().themeColorGrey,
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
        SizedBox(height: 12.w),
        SizedBox(
          height: 400.w,
          child: ValueListenableBuilder(
            valueListenable: model.loadingRelatedProducts,
            builder: (context, loadingRelatedProducts, child) {
              if (loadingRelatedProducts) {
                return _shimmerProductList();
              }
              return ValueListenableBuilder(
                valueListenable: model.relatedProducts,
                builder: (context, newProducts, child) {
                  return ListView(
                    scrollDirection: Axis.horizontal,
                    children: newProducts
                        .map(
                          (product) => _productItem(product, context),
                        )
                        .toList(),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _productItem(ProductModel product, BuildContext context) {
    return InkWell(
      onTap: () => model.onToProductDetail(product),
      child: Padding(
        key: ValueKey(product.name),
        padding: EdgeInsets.only(right: 11.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                SizedBox(
                  height: 275.w,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      _imageProduct(product),
                      _addToFavoriteButton(),
                    ],
                  ),
                ),
                ExtraProductDisplayWidget(
                  isNew: product.isNew,
                  salePercent: product.salePercent,
                  width: 140.w,
                ),
              ],
            ),
            _ratingProduct(),
            SizedBox(height: 6.w),
            _brandNameProduct(product),
            SizedBox(height: 5.w),
            _nameProduct(product),
            SizedBox(height: 4.w),
            PriceDisplayWidget(
              salePrice: product.price,
              originPrice: product.originPrice,
              salePercent: product.salePercent,
            ),
          ],
        ),
      ),
    );
  }

  Widget _nameProduct(ProductModel product) {
    return Text(product.name,
        style: text16.copyWith(
          color: getColor().themeColorBlackWhite,
        ),
        overflow: TextOverflow.ellipsis);
  }

  Widget _brandNameProduct(ProductModel product) {
    return Text(product.brandName,
        style: text11.copyWith(
          color: getColor().themeColorGrey,
        ),
        overflow: TextOverflow.ellipsis);
  }

  Widget _ratingProduct() {
    return Row(
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
    );
  }

  Widget _addToFavoriteButton() {
    return Positioned(
      bottom: 0.w,
      right: 0.w,
      child: AddToFavoriteButton(
        onTap: () {},
      ),
    );
  }

  Widget _imageProduct(ProductModel product) {
    return SizedBox(
      width: 150.w,
      height: 260.w,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          8.w,
        ),
        child: Image.network(
          fit: BoxFit.cover,
          product.urlImage,
        ),
      ),
    );
  }

  Widget _shimmerProductList() {
    return Shimmer.fromColors(
      baseColor: getColor().themeColorAAAAAAA.withOpacity(0.4),
      highlightColor: getColor().themeColorAAAAAAA.withOpacity(0.2),
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _shimmerProductItem(),
          _shimmerProductItem(),
          _shimmerProductItem(),
        ],
      ),
    );
  }

  Widget _shimmerProductItem() {
    return Padding(
      padding: EdgeInsets.only(right: 11.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 150.w,
            height: 260.w,
            decoration: BoxDecoration(
              color: getColor().themeColorAAAAAAA,
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          SizedBox(height: 10.w),
          Container(
            width: 150.w,
            height: 20.w,
            color: getColor().themeColorAAAAAAA,
          ),
          SizedBox(height: 10.w),
          Container(
            width: 150.w,
            height: 20.w,
            color: getColor().themeColorAAAAAAA,
          ),
          SizedBox(height: 10.w),
          Container(
            width: 150.w,
            height: 20.w,
            color: getColor().themeColorAAAAAAA,
          ),
          SizedBox(height: 10.w),
          Container(
            width: 150.w,
            height: 20.w,
            color: getColor().themeColorAAAAAAA,
          ),
          SizedBox(height: 10.w),
        ],
      ),
    );
  }
}
