import 'package:fiver/core/base/base_state.dart';
import 'package:fiver/core/extensions/ext_localization.dart';
import 'package:fiver/presentation/main/shop/components/category_list.dart';
import 'package:fiver/presentation/main/shop/shop_model.dart';
import 'package:fiver/presentation/widgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'components/components.dart';

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
    return Scaffold(
      appBar: CommonAppbar(
        title: context.loc.categories,
        centerTitle: true,
      ),
      body: SizedBox.expand(
        child: Column(
          children: [
            SizedBox(height: 8.w),
            GenderListCard(model: model),
            CategoryList(model: model),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
