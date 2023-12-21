import '../../core/extensions/ext_num.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/res/colors.dart';
import '../../core/res/theme/text_theme.dart';
import '../../core/res/theme/theme_manager.dart';

class PriceDisplayWidget extends StatelessWidget {
  const PriceDisplayWidget({
    super.key,
    required this.salePrice,
    required this.originPrice, required this.salePercent,
  });
  final num salePrice;
  final num originPrice;
  final num salePercent;
  @override
  Widget build(BuildContext context) {
      return salePercent > 0 ? _withSalePercent() : _withoutSalePercent();
  }

  Widget _withoutSalePercent() {
    return _originPriceProduct(originPrice,normalDisplay: true);
  }

  Widget _withSalePercent(){
     return Row(
            children: [
              _originPriceProduct(originPrice),
              SizedBox(width: 4.w),
              _priceProduct(salePrice),
            ],
          );
  }

  Widget _originPriceProduct(num price, {bool normalDisplay = false}) {
    return Text(
      price.priceWithUnit(),
      style: text14.medium.copyWith(
        color: normalDisplay ? getColor().themeColorBlackWhite : getColor().themeColorGrey,
        decoration: normalDisplay ? null :TextDecoration.lineThrough,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _priceProduct(num price) {
    return Text(
      price.priceWithUnit(),
      style: text14.medium.copyWith(
        color: colordb3022,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }
}
