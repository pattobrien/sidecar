import 'dart:async';
import 'dart:convert';

import 'package:riverpod/riverpod.dart';

import '../../protocol/protocol.dart';
import '../../services/active_project_service.dart';
import 'plugin.dart';

final activePackageProvider = FutureProvider<ActivePackage>((ref) async {
  final completer = Completer<RequestMessage>();
  final comm = ref.watch(communicationChannelProvider);
  final service = ref.watch(activeProjectServiceProvider);
  ref.listen<AsyncValue<dynamic>>(communitcationChannelStreamProvider,
      (_, event) {
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
  comm.sendMessage(response);
  return service.getActivePackageFromUri(request.root.root)!;
});
