import 'dart:async';

class Debouncer {
  Timer? timer;
  void run({
    int? milliseconds,
    required void Function() action,
    void Function()? timeOut,
  }) {
    if (timer?.isActive ?? true) {
      timer?.cancel();
    }
    timer = Timer(
      Duration(milliseconds: milliseconds ?? 300),
      () {
        action.call();
      },
    );
    Future.delayed(
      Duration(milliseconds: (milliseconds ?? 300) * 3),
      () {
        timeOut?.call();
      },
    );
  }
}
