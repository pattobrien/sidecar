import 'dart:convert';
import 'dart:isolate';

import 'package:riverpod/riverpod.dart';

import '../../protocol/protocol.dart';

final sidecarAnalyzerCommServiceProvider =
    Provider.family<SidecarAnalyzerCommService, SendPort>(
        (ref, sendPort) => SidecarAnalyzerCommService(sendPort));

final analyzerCommunicationStream = StreamProvider.family<dynamic, SendPort>(
    (ref, sendPort) =>
        ref.watch(sidecarAnalyzerCommServiceProvider(sendPort)).stream);

class SidecarAnalyzerCommService {
  SidecarAnalyzerCommService(this._sendPort) {
    _initialize();
  }

  final SendPort _sendPort;
  final ReceivePort _receivePort = ReceivePort();

  Stream<dynamic> get stream => _receivePort.asBroadcastStream();

  void sendToRunner(SidecarMessage message) {
    final json = message.toJson();
    final encodedJson = jsonEncode(json);
    _sendPort.send(encodedJson);
  }

  void sendNotification(
    SidecarNotification notification,
  ) {
    final wrappedResponse =
        SidecarMessage.notification(notification: notification);
    sendToRunner(wrappedResponse);
  }

  late Uri rootUri;

  void setUri(Uri uri) {
    rootUri = uri;
  }

  void _initialize() {
    _sendPort.send(_receivePort.sendPort);
  }
}
