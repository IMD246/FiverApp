import '../../core/res/theme/theme_manager.dart';
import 'package:flutter/material.dart';

import '../../core/base/base_state.dart';
import '../../core/extensions/ext_localization.dart';
import '../../data/model/filter_ui_model.dart';
import 'components/components.dart';
import 'filter_model.dart';
import '../widgets/common_appbar.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key, this.filterUIModel});
  final FilterUIModel? filterUIModel;
  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends BaseState<FilterModel, FilterPage> {
  @override
  void initState() {
    super.initState();
    model.init(widget.filterUIModel);
  }

  @override
  Widget buildContentView(BuildContext context, FilterModel model) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        model.onBack(newUpdate: false);
      },
      child: Column(
        children: [
          FilterRangeSlider(model: model),
          FilterColorList(model: model),
          FilterSizeList(model: model),
          const Spacer(),
          FilterBottom(model: model)
        ],
      ),
    );
  }

  @override
  CommonAppbar? get appbar => CommonAppbar(
        title: context.loc.filters,
        action: () {
          model.onBack(newUpdate: false);
        },
        trailing: [
          InkWell(
            onTap: model.clearAll,
            child: Icon(
              Icons.filter_list_off_outlined,
              color: getColor().themeColorBlackWhite,
            ),
          ),
        ],
      );

  @override
  bool get isNeedSafeAreaBuildContent => true;

  @override
  bool get isNeedSafeAreaBuildViewByState => false;
}
