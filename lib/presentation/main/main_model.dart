import 'dart:async';

import 'package:fiver/core/base/base_model.dart';
import 'package:flutter/widgets.dart';

class MainModel extends BaseModel {
  late final PageController pageController;

  ValueNotifier<int> tabValue = ValueNotifier(0);

  void init(int tabIndex) {
    pageController = PageController();
    Timer.periodic(const Duration(milliseconds: 20), (timer) {
      if (pageController.hasClients) {
        _onChangePageController(tabIndex);
        timer.cancel();
      }
    });
    onTabChanged(tabIndex, isInit: true);
  }

  void onTabChanged(int tabIndex, {bool isInit = false}) {
    if (tabValue.value == tabIndex) return;
    tabValue.value = tabIndex;
    if (!isInit) {
      _onChangePageController(tabIndex);
    }
  }

  void _onChangePageController(int indexPage) {
    if ((pageController.page ?? 0) == indexPage) return;
    pageController.animateToPage(
      indexPage,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  @override
  void disposeModel() {
    pageController.dispose();
    tabValue.dispose();
    super.disposeModel();
  }
}
