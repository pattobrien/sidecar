import 'dart:async';
import 'dart:convert';

import 'package:riverpod/riverpod.dart';

import '../../protocol/protocol.dart';
import '../context/active_package.dart';
import 'plugin.dart';

final activePackageProvider = FutureProvider<ActivePackage>((ref) async {
  final completer = Completer<RequestMessage>();
  final comm = ref.watch(sidecarAnalyzerCommServiceProvider);
  ref.listen<AsyncValue<dynamic>>(analyzerCommunicationStream, (_, event) {
    final dynamic value = event.value;
    if (value is String) {
      try {
        final json = jsonDecode(value) as Map<String, dynamic>;
        final msg = SidecarMessage.fromJson(json);
        if (msg is RequestMessage) {
          final request = msg.request;
          if (request is SetActivePackageRequest) completer.complete(msg);
        }
      } catch (e) {
        rethrow;
      }
    }
  });
  final message = await completer.future;
  final request = message.request as SetActivePackageRequest;
  final response =
      SidecarMessage.response(const SetActivePackageResponse(), id: message.id);
  comm.sendToRunner(response);
  return request.package;
});
