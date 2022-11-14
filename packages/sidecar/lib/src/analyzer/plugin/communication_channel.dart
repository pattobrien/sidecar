import 'dart:isolate';

import 'package:riverpod/riverpod.dart';

import '../../protocol/protocol.dart';

final communicationChannelProvider =
    Provider<CommunicationChannel>((ref) => throw UnimplementedError());

final communitcationChannelStreamProvider = StreamProvider<dynamic>(
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
    sendNotification(const InitCompleteNotification());
  }
}
