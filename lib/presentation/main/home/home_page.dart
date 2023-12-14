import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/base/base_state.dart';
import '../../../core/res/colors.dart';
import 'components/components.dart';
import 'home_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomeModel, HomePage>
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
  Widget buildContentView(BuildContext context, HomeModel model) {
    return RefreshIndicator(
      color: colorEF3651,
      onRefresh: () async {
        model.refresh();
      },
      child: SizedBox.expand(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BannerListCard(
                model: model,
              ),
              SizedBox(
                height: 32.w,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 18.w,
                ),
                child: Column(
                  children: [
                    SaleProductListCard(
                      model: model,
                    ),
                    SizedBox(
                      height: 8.w,
                    ),
                    NewProductListCard(
                      model: model,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
