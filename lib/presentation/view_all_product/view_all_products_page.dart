import '../../core/base/base_grid_state.dart';
import '../../core/enum.dart';
import '../../core/res/theme/text_theme.dart';
import '../../core/res/theme/theme_manager.dart';
import '../../data/model/product_model.dart';
import 'components/components.dart';
import 'view_all_products_model.dart';
import '../widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  Widget buildContentView(BuildContext context, ViewAllProductsModel model) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          widget.typeProduct.name,
          style: text30.bold.copyWith(
            color: getColor().themeColorBlackWhite,
          ),
        ),
        leading: const BackButtonWidget(),
      ),
      body: super.buildContentView(context, model),
    );
  }

  @override
  Widget buildItem(BuildContext context, ProductModel item, int index) {
    return ProductItemCard(
      product: item,
      index: index,
      typeProduct: widget.typeProduct,
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
