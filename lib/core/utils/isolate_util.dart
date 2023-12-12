import 'dart:isolate';

class IsolateUtil {
  static void sendDataFromPort(List<dynamic> params) {
    final SendPort sp = params[0];
    sp.send(params[1]);
  }

  static void killIsolate(
      {Isolate? isolate, int priority = Isolate.immediate}) {
    isolate?.kill(priority: priority);
  }

  static Future<dynamic> isolateFunction({
    required Future<dynamic> Function() actionFuture,
    required Isolate? isolate,
  }) async {
    final receivePort = ReceivePort();
    final value = await actionFuture();
    isolate = await Isolate.spawn(
      sendDataFromPort,
      [
        receivePort.sendPort,
        value,
      ],
    );
    killIsolate(isolate: isolate);
    return await receivePort.first;
  }
}
