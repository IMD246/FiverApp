import 'dart:developer';
import 'dart:io';

import '../enum.dart';
import '../res/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../di/locator_service.dart';
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
    return SafeArea(
      child: Consumer<ThemeManager>(
        builder: (context, theme, child) {
          return ChangeNotifierProvider<M>.value(
            value: model,
            builder: (context, child) {
              return Consumer<M>(
                builder: (context, model, child) {
                  if (Platform.isAndroid) {
                    return WillPopScope(
                      child: buildViewByState(context, model),
                      onWillPop: () async {
                        return await Future.value(model.onWillPop);
                      },
                    );
                  }
                  return buildViewByState(context, model);
                },
              );
            },
          );
        },
      ),
    );
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
    switch (model.viewState) {
      case ViewState.loading:
        return buildDefaultLoading();
      case ViewState.error:
        return ErrorWidget(Exception());
      case ViewState.loaded:
        return buildContentView(context, model);
      default:
        return const SizedBox();
    }
  }

  Widget buildContentView(BuildContext context, M model);

  Color get backgroundLoadingColor => getColor().bgColorWhiteBlack;

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
