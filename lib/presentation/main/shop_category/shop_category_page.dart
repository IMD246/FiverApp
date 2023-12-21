import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/base/base_state.dart';
import '../../../core/extensions/ext_localization.dart';
import '../../widgets/common_appbar.dart';
import 'components/components.dart';
import 'shop_category_model.dart';

class ShopCategoryPage extends StatefulWidget {
  const ShopCategoryPage({super.key});
  @override
  State<ShopCategoryPage> createState() => _ShopCategoryPageState();
}

class _ShopCategoryPageState
    extends BaseState<ShopCategoryModel, ShopCategoryPage>
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
  Widget buildContentView(BuildContext context, ShopCategoryModel model) {
    return SizedBox.expand(
      child: Column(
        children: [
          SizedBox(height: 8.w),
          GenderListCard(model: model),
          CategoryList(model: model),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  CommonAppbar? get appbar => CommonAppbar(
        title: context.loc.categories,
        isHideBackButton: true,
        centerTitle: true,
      );
}
