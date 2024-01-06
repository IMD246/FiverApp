import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/base/base_grid_state.dart';
import '../../../core/res/colors.dart';
import '../../../data/model/category_model.dart';
import '../../../data/model/product_model.dart';
import '../../widgets/common_appbar.dart';
import 'components/components.dart';
import 'shop_category_detail_model.dart';

class ShopCategoryDetailPage extends StatefulWidget {
  const ShopCategoryDetailPage({super.key, required this.category});
  final CategoryModel category;
  @override
  State<ShopCategoryDetailPage> createState() => _ShopCategoryDetailPageState();
}

class _ShopCategoryDetailPageState extends BaseGridState<
    ProductModel,
    ShopCategoryDetailModel,
    ShopCategoryDetailPage> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    model.init(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return super.buildContent();
  }

  @override
  Widget buildContentView(BuildContext context, ShopCategoryDetailModel model) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 12.r,
                color: color000000.withOpacity(0.12),
                offset: const Offset(0, 4),
                blurStyle: BlurStyle.outer,
                spreadRadius: 0,
              )
            ],
          ),
          child: Column(
            children: [
              ProductCategoryListCard(model: model),
              SizedBox(height: 18.w),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FilterProductByCategory(
                      onTap: model.onGoToFilter,
                    ),
                    SortBySelected(model: model),
                    ViewBy(model: model),
                  ],
                ),
              ),
              SizedBox(height: 10.w),
            ],
          ),
        ),
        Expanded(
          child: super.buildContentView(context, model),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  bool get shrinkWrap => false;

  @override
  EdgeInsets get paddingGrid => EdgeInsets.all(16.w);

  @override
  int get crossAxisCount => 2;

  @override
  Axis get axis => Axis.vertical;

  @override
  double get childAspectRatio => 0.52;

  @override
  CommonAppbar? get appbar => CommonAppbar(
        action: model.onBack,
        title: widget.category.name ?? "",
        centerTitle: true,
      );

  @override
  Widget buildItem(BuildContext context, ProductModel item, int index) {
    return InkWell(
      onTap: () => model.onToProductDetail(item),
      child: ProductItemCard(
        key: ValueKey(item.name),
        product: item,
        index: index,
      ),
    );
  }

  @override
  Widget buildEmptyView(BuildContext context) {
    return const ShimmerProductList();
  }
}
