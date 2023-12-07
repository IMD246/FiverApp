import 'dart:async';

import 'package:fiver/core/base/base_model.dart';
import 'package:fiver/core/extensions/ext_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  DateTime? currentBackPressTime;
  Future<bool> doubleTapToExistApp() {
    DateTime now = DateTime.now();
    int requiredSeconds = 2;
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) >
            Duration(seconds: requiredSeconds)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: currentContext.loc.tap_again_to_exit,
        toastLength: Toast.LENGTH_LONG,
      );
      Future.delayed(
        Duration(seconds: requiredSeconds),
        () => Fluttertoast.cancel(),
      );
      return Future.value(false);
    }
    return Future.value(false);
  }

  @override
  void disposeModel() {
    pageController.dispose();
    tabValue.dispose();
    super.disposeModel();
  }
}
