import '../widgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/base/base_grid_state.dart';
import '../../core/enum.dart';
import '../../core/res/theme/text_theme.dart';
import '../../core/res/theme/theme_manager.dart';
import '../../data/model/product_model.dart';
import 'components/components.dart';
import 'view_all_products_model.dart';

class ViewAllProductsPage extends StatefulWidget {
  const ViewAllProductsPage({super.key, required this.typeProduct});
  final TypeProduct typeProduct;
  @override
  State<ViewAllProductsPage> createState() => _ViewAllProductsPageState();
}

class _ViewAllProductsPageState extends BaseGridState<ProductModel,
    ViewAllProductsModel, ViewAllProductsPage> {
  @override
  void initState() {
    super.initState();
    model.init(widget.typeProduct);
  }

  @override
  CommonAppbar? get appbar => CommonAppbar(
        title: widget.typeProduct.name,
        titleStyle: text30.bold.copyWith(
          color: getColor().themeColorBlackWhite,
        ),
      );

  @override
  Widget buildItem(BuildContext context, ProductModel item, int index) {
    return ProductItemCard(
      key: ValueKey(item.name),
      product: item,
      index: index,
    );
  }

  @override
  Widget buildEmptyView(BuildContext context) {
    return const ShimmerProductList();
  }

  @override
  int get crossAxisCount => 2;

  @override
  Axis get axis => Axis.vertical;

  @override
  bool get shrinkWrap => false;

  @override
  double get childAspectRatio => 0.46;

  @override
  EdgeInsets get paddingGrid => EdgeInsets.all(8.w);
}
