import 'package:flutter/foundation.dart';

import '../enum.dart';
import 'base_model.dart';

abstract class BaseListModel<T> extends BaseModel {
  bool isShowKeyBoard = false;

  List<T> items = [];

  int page = 1;

  int get pageSize => 20;

  int get itemCount => items.length;

  @override
  ViewState get initState => ViewState.loading;

  bool get isGetDataLocal => false;

  ValueNotifier<bool> loadMoreValue = ValueNotifier(false);

  bool disableLoadMore = false;

  void loadData({dynamic params, bool isClear = false}) async {
    if (kDebugMode) {
      print(
          "\n\n*************************** page: $page ***************************\n\n");
    }
    try {
      final data = await getData(params: params, isClear: isClear);
      if (isClear) items.clear();
      disableLoadMore = data == null || data.isEmpty;
      if (data?.isNotEmpty == true) {
        items.addAll(data!);
        page++;
      }
      viewState = ViewState.loaded;
    } catch (e) {
      viewState = ViewState.loaded;
    }
    loadMoreValue.value = false;
    if (!isDisposed) notifyListeners();
  }

  void loadCacheData({dynamic params}) async {
    viewState = ViewState.loaded;
    try {
      final cacheData = await getCacheData(params: params);
      if (cacheData != null && cacheData.isNotEmpty) {
        items.clear();
        items.addAll(cacheData);
        page++;
        if (!isDisposed) notifyListeners();
      } else {
        viewState = ViewState.error;
      }
    } catch (e) {
      viewState = ViewState.error;
    }
    loadMoreValue.value = false;
    if (!isDisposed) notifyListeners();
  }

  void loadMoreData({dynamic params}) {
    if (loadMoreValue.value || disableLoadMore) return;
    loadMoreValue.value = true;
    if (!isDisposed) notifyListeners();
    loadData(params: params);
  }

  Future<void> refresh({dynamic params}) async {
    page = 1;
    loadData(params: params, isClear: true);
  }

  void clearAll() {
    page = 1;
    items.clear();
    if (!isDisposed) notifyListeners();
  }

  Future<List<T>?> getData({dynamic params, bool isClear});

  Future<List<T>?>? getCacheData({dynamic params}) {
    return null;
  }
}
