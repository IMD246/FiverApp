import '../../presentation/widgets/empty_data_widget.dart';
import 'package:flutter/material.dart';

import 'base_list_model.dart';
import 'base_list_state.dart';

abstract class BaseGridState<I, M extends BaseListModel<I>,
    W extends StatefulWidget> extends BaseListState<I, M, W> {
  @override
  Widget buildContentView(BuildContext context, M model) {
    Widget content;
    if (model.items.isEmpty) {
      content = buildEmptyView(context);
    } else if (isGridInsideScrollView) {
      content = SingleChildScrollView(
        child: GridView.count(
          crossAxisCount: crossAxisCount,
          physics: scrollPhysics,
          padding: paddingGrid,
          controller: controller,
          scrollDirection: axis,
          childAspectRatio: childAspectRatio,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          shrinkWrap: shrinkWrap,
          children: model.items
              .map((e) => buildItem(context, e, model.items.indexOf(e)))
              .toList(),
        ),
      );
    } else {
      content = GridView.builder(
        itemCount: model.items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: childAspectRatio,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
        ),
        padding: paddingGrid,
        physics: scrollPhysics,
        controller: controller,
        scrollDirection: axis,
        itemBuilder: (context, index) {
          final item = model.items[index];
          return buildItem(context, item, index);
        },
      );
    }
    if (enableRefresh) {
      content = RefreshIndicator(onRefresh: onRefresh, child: content);
    }
    return content;
  }

  @override
  Widget buildEmptyView(BuildContext context) {
    return const EmptyDataWidget();
  }

  int crossAxisCount = 2;

  double childAspectRatio = 1;

  double mainAxisSpacing = 0;

  double crossAxisSpacing = 0;

  double gridMarginHorizontal = 0;

  @override
  bool get shrinkWrap => false;

  Axis get axis => Axis.vertical;

  ScrollPhysics get scrollPhysics => const AlwaysScrollableScrollPhysics();

  EdgeInsets get paddingGrid =>
      EdgeInsets.symmetric(horizontal: gridMarginHorizontal);

  int get loadMoreBeforeRange => 6;

  int get scrollOffset => 500;

  bool get isGridInsideScrollView => false;

  double? get mainAxisExtent => null;
}
