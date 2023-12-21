import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/res/icons.dart';
import '../../../core/res/theme/text_theme.dart';
import '../../../core/res/theme/theme_manager.dart';
import '../../../data/model/product_model.dart';
import '../../widgets/extra_product_display_widget.dart';
import '../../widgets/price_display_widget.dart';

class ProductItemCard extends StatelessWidget {
  const ProductItemCard({
    super.key,
    required this.product,
    required this.index,
  });
  final ProductModel product;
  final int index;
  @override
  Widget build(BuildContext context) {
    return _productItem(product, context);
  }

  Widget _productItem(ProductModel product, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: (index % 2 != 0) ? 0 : 16.w),
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
              ExtraProductDisplayWidget(
                isNew: product.isNew,
                salePercent: product.salePercent,
                width: 156.w,
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
      height: 265.w,
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
}
