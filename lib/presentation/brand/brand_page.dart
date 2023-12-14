import '../../core/base/base_list_state.dart';
import '../../core/res/colors.dart';
import '../../core/res/theme/text_theme.dart';
import '../../core/res/theme/theme_manager.dart';
import '../../data/model/brand_model.dart';
import '../widgets/input/search_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/extensions/ext_localization.dart';
import '../widgets/common_appbar.dart';
import '../widgets/is_taping_text.dart';
import 'brand_model.dart';
import 'components/components.dart';

class BrandPage extends StatefulWidget {
  const BrandPage({super.key, required this.brands});
  final List<MBrand> brands;
  @override
  State<BrandPage> createState() => _BrandPageState();
}

class _BrandPageState extends BaseListState<MBrand, BrandModel, BrandPage> {
  @override
  void initState() {
    super.initState();
    model.init(widget.brands);
  }

  @override
  Widget buildContentView(BuildContext context, BrandModel model) {
    return WillPopScope(
      onWillPop: () async {
        model.onBack(newUpdate: false);
        return true;
      },
      child: Column(
        children: [
          SizedBox(height: 16.w),
          Padding(
            padding: padding,
            child: SearchTextInput(
              controller: model.searchCtr,
              hintText: context.loc.search,
              label: "",
            ),
          ),
          Padding(padding: padding),
          SizedBox(height: 24.w),
          Expanded(
            child: super.buildContentView(
              context,
              model,
            ),
          ),
          FilterBottom(model: model)
        ],
      ),
    );
  }

  @override
  EdgeInsets get padding => EdgeInsets.symmetric(horizontal: 16.w);

  @override
  CommonAppbar? get appbar => CommonAppbar(
        title: context.loc.brand,
        action: () {
          model.onBack(newUpdate: false);
        },
      );

  @override
  Widget buildEmptyView(BuildContext context) {
    return Padding(
      padding: padding,
      child: ValueListenableBuilder(
        valueListenable: model.isReadyOnApply,
        builder: (context, isReadyOnApply, child) {
          if (!isReadyOnApply) {
            return const ShimmerBrandList();
          }
          return IsTapingText(
            isTaping: model.isTaping,
          );
        },
      ),
    );
  }

  @override
  Widget buildItem(BuildContext context, MBrand item, int index) {
    return Padding(
      key: ValueKey(item.id),
      padding: EdgeInsets.only(bottom: 32.w),
      child: InkWell(
        onTap: () {
          model.updateBrand(item);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              item.name,
              style: text16.copyWith(
                color: model.checkMatchedBrand(item)
                    ? colorEF3651
                    : getColor().themeColor222222White,
              ),
            ),
            Transform.scale(
              scale: 1.2,
              child: Checkbox(
                activeColor: colorEF3651,
                checkColor: colorWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r),
                ),
                side: MaterialStateBorderSide.resolveWith(
                  (states) => BorderSide(
                    width: 1.0.w,
                    color: model.checkMatchedBrand(item)
                        ? Colors.transparent
                        : getColor().themeColorBlackWhite,
                  ),
                ),
                value: model.checkMatchedBrand(item),
                onChanged: (_) {
                  model.updateBrand(item);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
