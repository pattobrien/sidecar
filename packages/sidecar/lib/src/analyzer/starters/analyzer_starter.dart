import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:riverpod/riverpod.dart';

import '../../protocol/protocol.dart';
import '../../rules/rules.dart';
import '../plugin/rule_constructors_provider.dart';
import '../plugin/sidecar_analyzer.dart';
import '../plugin/sidecar_analyzer_comm_service.dart';

Future<SidecarAnalyzer> analyzerStarter({
  required SendPort sendPort,
  List<SidecarBaseConstructor> constructors = const [],
}) {
  return runZonedGuarded<Future<SidecarAnalyzer>>(() async {
    final container = ProviderContainer(
      overrides: [
        ruleConstructorProvider.overrideWithValue(constructors),
      ],
      observers: [
        //
      ],
    );
    final service =
        container.read(sidecarAnalyzerCommServiceProvider(sendPort));
    final completer = Completer<RequestMessage>();
    final sub = container
        .read(analyzerCommunicationStream(sendPort).stream)
        .listen((dynamic event) {
      if (event is String) {
        try {
          final json = jsonDecode(event) as Map<String, dynamic>;
          final msg = SidecarMessage.fromJson(json);
          if (msg is RequestMessage) {
            final request = msg.request;
            if (request is SetActiveRootRequest) {
              completer.complete(msg);
            }
          }
        } catch (e) {
          rethrow;
        }
      }
    });
    service.sendNotification(const InitCompleteNotification());
    final request = await completer.future;

    final analyzer =
        SidecarAnalyzer(container, sP: sendPort, initRequest: request);
    await sub.cancel();
    return analyzer;
  }, (error, stack) {
    final msg = ErrorMessage('$error', stack);
    final json = msg.toJson();
    final encodedJson = jsonEncode(json);
    sendPort.send(encodedJson);
    throw UnimplementedError('INVALID ERROR: $error $stack');
  }, zoneSpecification: ZoneSpecification(
    print: (self, parent, zone, line) {
      try {
        // final json = jsonDecode(line) as Map<String, dynamic>;
        // final msg = SidecarMessage.fromJson(json);
        // if (msg is LogMessage) {
        return sendPort.send(line);
        // }
        // throw UnimplementedError(
        //     'unexpected log message format: ${msg.runtimeType}');
      } catch (e, stack) {
        throw UnimplementedError('unexpected analyzer zone error: $e, $stack');
      }
    },
  ))!;
}
