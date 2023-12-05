import 'dart:developer';

import 'package:fiver/core/utils/deboucer.dart';
import 'package:flutter/widgets.dart';

class TextEditingControllerCustom extends TextEditingController {
  late final Debouncer _debouncer;
  TextEditingControllerCustom({String? value}) {
    _debouncer = Debouncer();
    text = value ?? "";
  }

  void listener({
    int? milliseconds,
    required Function() action,
  }) {
    addListener(() {
      _debouncer.run(
        milliseconds: milliseconds,
        action: action,
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
