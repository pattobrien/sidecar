import 'dart:isolate';

import 'package:riverpod/riverpod.dart';

import '../../protocol/protocol.dart';

class CommunicationChannel {
  CommunicationChannel(this._sendPort) {
    initialize();
  }

  void initialize() => _sendPort.send(_receivePort.sendPort);

  Stream<dynamic> get stream => _receivePort.asBroadcastStream();

  void sendMessage(SidecarMessage message) {
    _sendPort.send(message.toEncodedJson());
  }

  void sendNotification(SidecarNotification notification) {
    final response = SidecarMessage.notification(notification: notification);
    sendMessage(response);
  }

  void handleError(ActivePackage package, Object error, StackTrace stack) {
    final log = LogRecord.fromAnalyzer(error.toString(), DateTime.now(),
        severity: LogSeverity.error,
        root: package.packageRoot,
        stackTrace: stack);
    final message = SidecarMessage.log(log);
    sendMessage(message);
  }

  final SendPort _sendPort;
  final ReceivePort _receivePort = ReceivePort();
}

final communicationChannelProvider =
    Provider<CommunicationChannel>((ref) => throw UnimplementedError());

final communicationChannelStreamProvider = StreamProvider<dynamic>(
    (ref) => ref.watch(communicationChannelProvider).stream);
