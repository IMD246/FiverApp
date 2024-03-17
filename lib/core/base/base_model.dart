import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fiver/core/extensions/ext_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../data/data_source/remote/api_reponse/exceptions/api_exception.dart';
import '../../data/model/user_info_model.dart';
import '../app/app_model.dart';
import '../app/user_model.dart';
import '../di/locator_service.dart';
import '../enum.dart';
import '../event/user_update_model_event.dart';
import '../utils/navigation_service.dart';
import '../utils/util.dart';
import 'handle_error.dart';

abstract class BaseModel extends ChangeNotifier {
  StreamSubscription? updateProfileStream;
  ViewState? viewState;

  ViewState get initState => ViewState.loaded;

  bool isDisposed = false;
  bool onWillPop = true;
  UserInfoModel? user;
  final GlobalKey<ScaffoldMessengerState> appKey =
      NavigationService.scaffoldKey;

  BuildContext get currentContext => appKey.currentContext!;

  BaseModel() {
    viewState = initState;
  }

  void initData() {
    user = locator<UserModel>().userInfo;
    updateProfileStream =
        eventBus.on<UserInfoModelUpdateEvent>().listen((event) {
      user = event.user;
      notifyListeners();
    });
  }

  void setState(ViewState newState, {forceUpdate = false, dynamic error}) {
    if (viewState == newState && !forceUpdate) return;
    viewState = newState;
    if (viewState == ViewState.error && error != null) {}
  }

  String _getErrorMessage(dynamic error) {
    if (error is HandleError) {
      return error.message;
    }
    if (error is DioException && error.response?.statusCode != 422) {
      return "${error.response?.data?['message'] ?? ""}";
    }
    return "unknown";
  }

  void _onHandleErrorException(
    dynamic e, {
    void Function(ValidatorModel validator)? callBackValidator,
  }) {
    if (e is DioException && e.response?.statusCode == 422) {
      _handleValidateError(e, callBackValidator);
      return;
    }
    showErrorException(e);
  }

  void showErrorException(dynamic e) {
    final getError = _getErrorMessage(e);
    EasyLoading.showError(getError);
  }

  void _handleValidateError(
    DioException object,
    Function(ValidatorModel validator)? callBackValidator,
  ) {
    final validator = getValidatorFromDioException(object);
    if (validator == null) {
      return;
    }
    if (callBackValidator != null) {
      callBackValidator(validator);
    }
  }

  void execute(
    Function action, {
    bool needShowLoading = true,
    bool forceBack = false,
    void Function(ValidatorModel validator)? callBackValidator,
    void Function(dynamic e)? customOnErrorFunction,
  }) async {
    try {
      if (!forceBack) {
        onWillPop = false;
      }
      if (needShowLoading) {
        EasyLoading.show(
          status: currentContext.loc.loading,
          maskType: EasyLoadingMaskType.black,
        );
      }

      await action();
    } catch (e) {
      if (customOnErrorFunction != null) {
        customOnErrorFunction(e);
      } else {
        _onHandleErrorException(e, callBackValidator: callBackValidator);
      }
    } finally {
      if (!forceBack) {
        onWillPop = true;
      }
      if (needShowLoading) {
        EasyLoading.dismiss();
      }
    }
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
