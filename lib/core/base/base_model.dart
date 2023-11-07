import 'dart:developer';

import 'package:fiver/core/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../utils/navigation_service.dart';
import 'handle_error.dart';

abstract class BaseModel extends ChangeNotifier {
  ViewState? _viewState;
  ViewState get viewState => _viewState ?? ViewState.loaded;
  bool isDisposed = false;
  bool onWillPop = true;
  final GlobalKey<ScaffoldMessengerState> appKey =
      NavigationService.scaffoldKey;
  BuildContext get currentContext => appKey.currentContext!;
  initData() {}

  setState(ViewState newState, {forceUpdate = false, dynamic error}) {
    if (viewState == newState && !forceUpdate) return;
    _viewState = newState;
    if (viewState == ViewState.error && error != null) {}
  }

  String getErrorMessage(dynamic error) {
    if (error is HandleError) {
      return error.message;
    }
    return "unknown";
  }

  showErrorException(dynamic error) {
    final getError = getErrorMessage(error);
    EasyLoading.showError(getError);
  }

  @override
  void dispose() {
    disposeModel();
    isDisposed = true;
    super.dispose();
    log("-------------------------dispose()--------------------------",
        name: "$runtimeType");
  }

  void disposeModel() {
    log("-------------------------disposeModel()--------------------------",
        name: "$runtimeType");
  }
}