import 'dart:developer';
import 'dart:io';

import '../routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../presentation/widgets/common_appbar.dart';
import '../di/locator_service.dart';
import '../enum.dart';
import '../res/theme/theme_manager.dart';
import 'base_model.dart';

abstract class BaseState<M extends BaseModel, W extends StatefulWidget>
    extends State<W> {
  late M model;

  @override
  Widget build(BuildContext context) {
    return buildContent();
  }

  M _createModel() => locator<M>();

  @override
  void initState() {
    super.initState();
    log("-------------------------initState()--------------------------",
        name: "$runtimeType");
    model = _createModel();
    model.initData();
  }

  Widget buildContent() {
    Widget content;
    content = Consumer<ThemeManager>(
      builder: (context, theme, child) {
        return child!;
      },
      child: ChangeNotifierProvider<M>.value(
        value: model,
        builder: (context, child) {
          return child!;
        },
        child: Consumer<M>(
          builder: (context, model, child) {
            Widget content = child!;

            if (isNeedPopScopeOnTop && Platform.isAndroid) {
              content = PopScope(
                canPop: model.onWillPop,
                onPopInvoked: (didPop) {
                  if (didPop) {
                    return;
                  }
                  AppRouter.router.pop();
                },
                child: content,
              );
            }

            return content;
          },
          child: buildViewByState(context, model),
        ),
      ),
    );
    if (isNeedSafeAreaBuildContent) {
      return SafeArea(child: content);
    }
    return content;
  }

  Widget buildDefaultLoading() {
    return Container(
      width: 1.sw,
      height: 1.sh,
      color: backgroundLoadingColor,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget buildViewByState(BuildContext context, M model) {
    Widget body;
    switch (model.viewState) {
      case ViewState.loading:
        body = buildDefaultLoading();
        break;
      case ViewState.error:
        body = ErrorWidget(Exception());
        break;
      case ViewState.loaded:
        body = buildContentView(context, model);
        break;
      default:
        body = const SizedBox();
    }

    if (isNeedSafeAreaBuildViewByState) body = SafeArea(child: body);

    return Scaffold(
      backgroundColor: bgColorScaffold,
      appBar: appbar,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButtonLocation: floatingActionButtonLocation ??
          FloatingActionButtonLocation.centerDocked,
      floatingActionButton: floatingActionButton,
      body: body,
    );
  }

  Widget buildContentView(BuildContext context, M model);

  Color? get backgroundLoadingColor => getColor().bgColorWhiteBlack;

  CommonAppbar? appbar;

  Color? bgColorScaffold;

  Widget? bottomNavigationBar;

  bool isNeedSafeAreaBuildContent = false;

  bool isNeedSafeAreaBuildViewByState = true;

  FloatingActionButtonLocation? floatingActionButtonLocation;

  Widget? floatingActionButton;

  bool isNeedPopScopeOnTop = true;

  @override
  void dispose() {
    model.dispose();
    disposePage();
    super.dispose();
    log("-------------------------dispose()--------------------------",
        name: "$runtimeType");
  }

  void disposePage() {
    log("-------------------------disposePage()--------------------------",
        name: "$runtimeType");
  }
}
