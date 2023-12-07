import 'dart:isolate';

class IsolateUtil {
  static void sendDataFromPort(List<dynamic> params) {
    final SendPort sp = params[0];
    sp.send(params[1]);
  }
  static void killIsolate({Isolate? isolate, int priority = Isolate.immediate}) {
    isolate?.kill(priority: priority);
  }
}
