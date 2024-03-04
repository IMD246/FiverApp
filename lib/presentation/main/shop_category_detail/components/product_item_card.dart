import '../../../widgets/add_to_favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/res/theme/text_theme.dart';
import '../../../../core/res/theme/theme_manager.dart';
import '../../../../data/model/product_model.dart';
import '../../../widgets/extra_product_display_widget.dart';
import '../../../widgets/price_display_widget.dart';

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
      padding: EdgeInsets.only(right: index % 2 == 0 ? 8.w : 2.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                SizedBox(
                  height: 184.w,
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
                  width: 156.w,
                ),
              ],
            ),
          ),
          SizedBox(height: 7.w),
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
      bottom: -15.w,
      right: 0.w,
      child: AddToFavoriteButton(
        onTap: () {},
      ),
    );
  }

  Widget _imageProduct(ProductModel product) {
    return SizedBox(
      height: 184.w,
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
