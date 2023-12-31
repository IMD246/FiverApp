import 'dart:developer';

import 'package:flutter/widgets.dart';

import 'deboucer.dart';

class TextEditingControllerCustom extends TextEditingController {
  late final Debouncer _debouncer;
  TextEditingControllerCustom({String? value}) {
    _debouncer = Debouncer();
    text = value ?? "";
  }

  void listener({
    int? milliseconds,
    required Function() action,
    void Function()? timeOut,
  }) {
    addListener(() {
      _debouncer.run(
        milliseconds: milliseconds,
        action: action,
        timeOut: timeOut,
      );
    });
  }

  @override
  void dispose() {
    _debouncer.timer?.cancel();
    if (!(_debouncer.timer?.isActive ?? false)) {
      log("-------------------------disposeTimerAndTextController--------------------------",
          name: "$runtimeType");
    }
    super.dispose();
  }
}
