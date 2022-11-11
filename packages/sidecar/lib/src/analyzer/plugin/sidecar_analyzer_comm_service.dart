import 'dart:convert';
import 'dart:isolate';

import 'package:riverpod/riverpod.dart';

import '../../protocol/protocol.dart';

final sidecarAnalyzerCommServiceProvider =
    Provider<SidecarAnalyzerCommService>((ref) => SidecarAnalyzerCommService());

final analyzerCommunicationStream = StreamProvider<dynamic>(
    (ref) => ref.watch(sidecarAnalyzerCommServiceProvider).stream);

final listener = Provider((ref) async {
  final x = ref.watch(analyzerCommunicationStream);
  // print('received: $x');
});

class SidecarAnalyzerCommService {
  SidecarAnalyzerCommService() {
    // initialize();
  }

  late final SendPort _sendPort;
  // final Uri root;
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

  void initialize(SendPort sendPort) {
    _sendPort = sendPort;
    _sendPort.send(_receivePort.sendPort);
  }
}
