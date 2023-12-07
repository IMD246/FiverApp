import 'package:fiver/core/extensions/ext_localization.dart';
import 'package:fiver/core/res/colors.dart';
import 'package:fiver/core/res/icons.dart';
import 'package:fiver/core/res/theme/text_theme.dart';
import 'package:fiver/core/res/theme/theme_manager.dart';
import 'package:fiver/core/utils/util.dart';
import 'package:fiver/data/model/product_model.dart';
import 'package:fiver/presentation/main/home/home_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

class NewProductListCard extends StatelessWidget {
  const NewProductListCard({
    super.key,
    required this.model,
  });
  final HomeModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.loc.new_title,
              style: text34.bold,
            ),
            Text(
              context.loc.view_all,
              style: text11,
            ),
          ],
        ),
        SizedBox(height: 22.w),
        SizedBox(
          height: 420.w,
          child: ValueListenableBuilder(
            valueListenable: model.newProducts,
            builder: (context, newProducts, child) {
              if (newProducts.isNullOrEmpty) {
                return _shimmerProductList();
              }
              return ListView(
                scrollDirection: Axis.horizontal,
                children: newProducts
                    .map(
                      (product) => _productItem(product, context),
                    )
                    .toList(),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _productItem(ProductModel product, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 17.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                height: 275.w,
                child: Stack(
                  children: [
                    _imageProduct(product),
                    _addToFavoriteButton(),
                  ],
                ),
              ),
              _newProduct(product, context),
            ],
          ),
          _ratingProduct(),
          SizedBox(height: 6.w),
          _brandNameProduct(product),
          SizedBox(height: 5.w),
          _nameProduct(product),
          SizedBox(height: 4.w),
          Row(
            children: [
              _originPriceProduct(product),
              SizedBox(width: 4.w),
              _priceProduct(product),
            ],
          ),
        ],
      ),
    );
  }

  Widget _priceProduct(ProductModel product) {
    return Text(
      priceWithUnit(product.price),
      style: text14.medium.copyWith(
        color: colordb3022,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _originPriceProduct(ProductModel product) {
    return Text(
      priceWithUnit(product.originPrice),
      style: text14.medium.copyWith(
          color: getColor().themeColorGrey,
          decoration: TextDecoration.lineThrough,
          overflow: TextOverflow.ellipsis),
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
        Text("(10)",
            style: text10.copyWith(
              color: getColor().themeColorBlackWhite,
            ),
            overflow: TextOverflow.ellipsis),
      ],
    );
  }

  Widget _newProduct(ProductModel product, BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
            alignment: AlignmentDirectional.center,
            width: 48.w,
            height: 28.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(29.r),
              color: color222222,
            ),
            child: Text(
              context.loc.new_title.toUpperCase(),
              style: text11.copyWith(
                color: getColor().themeColorWhiteBlack,
              ),
            )),
      ),
    );
  }

  Widget _addToFavoriteButton() {
    return Positioned(
      bottom: 0.w,
      right: 0.w,
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        width: 36.w,
        height: 36.w,
        child: SvgPicture.asset(
          fit: BoxFit.scaleDown,
          DIcons.addToFavorite,
          width: 24.w,
          height: 24.w,
        ),
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
      padding: EdgeInsets.only(right: 17.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 150.w,
            height: 276.w,
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
