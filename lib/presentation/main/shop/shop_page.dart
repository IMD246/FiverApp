import 'package:fiver/core/base/base_state.dart';
import 'package:fiver/presentation/main/shop/shop_model.dart';
import 'package:fiver/presentation/main/shop_category/shop_category_page.dart';
import 'package:fiver/presentation/main/shop_category_detail/shop_category_detail_page.dart';
import 'package:flutter/material.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});
  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends BaseState<ShopModel, ShopPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    model.init();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return super.buildContent();
  }

  @override
  Widget buildContentView(BuildContext context, ShopModel model) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: model.pageController,
      children: [
        const ShopCategoryPage(),
        _detailCategoryPage(),
      ],
    );
  }

  Widget _detailCategoryPage() {
    return ValueListenableBuilder(
      valueListenable: model.category,
      builder: (context, category, child) {
        if (category == null) {
          return Container();
        }
        return ShopCategoryDetailPage(
          category: model.category.value!,
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
