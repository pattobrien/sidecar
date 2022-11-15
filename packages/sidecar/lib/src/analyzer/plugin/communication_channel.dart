import 'dart:isolate';

import 'package:riverpod/riverpod.dart';

import '../../protocol/logging/log_record.dart';
import '../../protocol/protocol.dart';

final communicationChannelProvider =
    Provider<CommunicationChannel>((ref) => throw UnimplementedError());

final communicationChannelStreamProvider = StreamProvider<dynamic>(
    (ref) => ref.watch(communicationChannelProvider).stream);

class CommunicationChannel {
  CommunicationChannel(this._sendPort) {
    initialize();
  }

  final SendPort _sendPort;
  final ReceivePort _receivePort = ReceivePort();

  Stream<dynamic> get stream => _receivePort.asBroadcastStream();

  void sendMessage(SidecarMessage message) {
    _sendPort.send(message.toEncodedJson());
  }

  void sendNotification(
    SidecarNotification notification,
  ) {
    final response = SidecarMessage.notification(notification: notification);
    sendMessage(response);
  }

  void initialize() {
    _sendPort.send(_receivePort.sendPort);
    // sendNotification(const InitCompleteNotification());
  }

  void handleError(ActivePackage package, Object error, StackTrace stack) {
    final log = LogRecord.fromAnalyzer(error.toString(), DateTime.now(),
        severity: LogSeverity.error,
        root: package.packageRoot,
        stackTrace: stack);
    final message = SidecarMessage.log(log);
    sendMessage(message);
  }
}
