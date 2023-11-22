import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fiver/core/di/locator_service.dart';
import 'package:fiver/core/enum.dart';
import 'package:fiver/core/event/user_update_model_event.dart';
import 'package:fiver/data/model/info_user_access_token.dart';
import 'package:fiver/domain/provider/app_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../domain/provider/user_model.dart';
import '../utils/navigation_service.dart';
import 'handle_error.dart';

abstract class BaseModel extends ChangeNotifier {
  StreamSubscription? updateProfileStream;
  ViewState? _viewState;
  ViewState get viewState => _viewState ?? ViewState.loaded;
  bool isDisposed = false;
  bool onWillPop = true;
  UserInfoModel? user;
  final GlobalKey<ScaffoldMessengerState> appKey =
      NavigationService.scaffoldKey;
  BuildContext get currentContext => appKey.currentContext!;

  initData() {
    user = locator<UserModel>().userInfo;
    updateProfileStream =
        eventBus.on<UserInfoModelUpdateEvent>().listen((event) {
      user = event.user;
      notifyListeners();
    });
  }

  setState(ViewState newState, {forceUpdate = false, dynamic error}) {
    if (viewState == newState && !forceUpdate) return;
    _viewState = newState;
    if (viewState == ViewState.error && error != null) {}
  }

  String getErrorMessage(dynamic error) {
    if (error is HandleError) {
      return error.message;
    }
    if (error is DioException && error.response?.statusCode != 422) {
      return error.response?.data['message'] ?? "";
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
    updateProfileStream?.cancel();
    super.dispose();
    log("-------------------------dispose()--------------------------",
        name: "$runtimeType");
  }

  void disposeModel() {
    log("-------------------------disposeModel()--------------------------",
        name: "$runtimeType");
  }
}
