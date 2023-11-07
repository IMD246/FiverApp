import 'dart:async';

class Debouncer {
  Timer? timer;
  Future<void> run({
    int? milliseconds,
    required Function() action,
  }) async {
    if (timer?.isActive ?? true) {
      timer?.cancel();
    }
    timer = Timer(Duration(milliseconds: milliseconds ?? 300), action);
  }
}
