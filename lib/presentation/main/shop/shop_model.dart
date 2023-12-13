import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../core/app/app_model.dart';
import '../../../core/base/base_model.dart';
import '../../../core/event/category_detail_event.dart';
import '../../../core/utils/util.dart';
import '../../../data/model/category_model.dart';

class ShopModel extends BaseModel {
  late final PageController pageController;
  final ValueNotifier<CategoryModel?> category = ValueNotifier(null);
  StreamSubscription<CategoryDetailEvent>? streamCategoryDetail;
  void init() {
    pageController = PageController();
    streamCategoryDetail = eventBus.on<CategoryDetailEvent>().listen((event) {
      setValueNotifier(category, event.category);
      if (event.category != null) {
        onChangedPage(1);
      } else {
        onChangedPage(0);
      }
    });
  }

  void onChangedPage(int index) {
    final currentPage = (pageController.page?.toInt() ?? 0);
    log("currentPage: $currentPage");
    if (currentPage == index) return;
    pageController.jumpToPage(index);
  }

  @override
  void disposeModel() {
    pageController.dispose();
    streamCategoryDetail?.cancel();
    super.disposeModel();
  }
}
