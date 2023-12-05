import 'dart:async';

class Debouncer {
  Timer? timer;
  void run({
    int? milliseconds,
    required Function() action,
  }) {
    if (timer?.isActive ?? true) {
      timer?.cancel();
    }
    timer = Timer(Duration(milliseconds: milliseconds ?? 300), action);
  }
}
