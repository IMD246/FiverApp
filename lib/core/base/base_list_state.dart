import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../../presentation/widgets/empty_data_widget.dart';
import '../res/theme/theme_manager.dart';
import 'base_list_model.dart';
import 'base_state.dart';

abstract class BaseListState<I, M extends BaseListModel<I>,
    W extends StatefulWidget> extends BaseState<M, W> {
  late ScrollController controller;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(_scrollListener);
    model.loadData();
    KeyboardVisibilityController().onChange.listen((bool visible) {
      model.isShowKeyBoard = visible;
    });
  }

  void jumpToTop() {
    controller.animateTo(
      0.0,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget buildContentView(BuildContext context, M model) {
    Widget content;
    if (model.items.isEmpty) {
      content = Stack(children: <Widget>[
        buildEmptyView(context),
        ListView(
          physics: const AlwaysScrollableScrollPhysics(),
        ),
      ]);
    } else if (isListInsideScrollView) {
      content = SingleChildScrollView(
        child: ListView.separated(
            physics: physics,
            shrinkWrap: shrinkWrap,
            reverse: reverse,
            padding: padding,
            controller: controller,
            scrollDirection: getScrollDirection,
            primary: false,
            itemBuilder: (context, index) =>
                buildItem(context, model.items[index], index),
            separatorBuilder: (context, index) =>
                buildSeparator(context, index),
            itemCount: model.items.length),
      );
    } else {
      content = ListView.separated(
          physics: physics,
          shrinkWrap: shrinkWrap,
          reverse: reverse,
          padding: padding,
          controller: controller,
          scrollDirection: getScrollDirection,
          primary: false,
          itemBuilder: (context, index) =>
              buildItem(context, model.items[index], index),
          separatorBuilder: (context, index) => buildSeparator(context, index),
          itemCount: model.items.length);
    }
    if (enableRefresh) {
      content = RefreshIndicator(
        onRefresh: onRefresh,
        key: refreshIndicatorKey,
        child: content,
      );
    }
    return content;
  }

  void _scrollListener() {
    final isScrollUp =
        controller.position.userScrollDirection == ScrollDirection.forward;
    if (controller.position.extentAfter < rangeLoadMore &&
        !isScrollUp &&
        !model.isShowKeyBoard) {
      if (kDebugMode) {
        print('KeyboardIsShow: ${model.isShowKeyBoard}');
        print("LoadMoreMore");
      }
      model.loadMoreData();
    }
  }

  Future<void> onRefresh() async {
    return model.refresh();
  }

  // @override
  // void onRetry() {
  //   model.loadData();
  // }

  Widget buildItem(BuildContext context, I item, int index);

  Widget buildSeparator(BuildContext context, int index) {
    return Container(
      height: itemSpacing,
      color: dividerColor,
    );
  }

  Widget buildEmptyView(BuildContext context) {
    return const EmptyDataWidget();
  }

  bool get enableRefresh => true;

  EdgeInsets get padding => const EdgeInsets.all(0);

  double get itemSpacing => 0;

  bool get autoLoadData => true;

  bool get shrinkWrap => false;

  bool get reverse => false;

  bool get isLoadCacheData => false;

  double get rangeLoadMore => 500;

  bool get isListInsideScrollView => false;

  Color get dividerColor => getColor().bgColorWhiteBlack;

  Axis get getScrollDirection => Axis.vertical;

  ScrollPhysics get physics => const AlwaysScrollableScrollPhysics();

  @override
  bool get isNeedSafeAreaBuildContent => true;

  @override
  bool get isNeedSafeAreaBuildViewByState => false;
}
