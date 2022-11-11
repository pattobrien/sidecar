import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:riverpod/riverpod.dart';

import '../../protocol/logging/log_record.dart';
import '../../protocol/protocol.dart';
import '../../rules/rules.dart';
import '../plugin/analysis_contexts_provider.dart';
import '../plugin/rule_constructors_provider.dart';
import '../plugin/sidecar_analyzer.dart';
import '../plugin/sidecar_analyzer_comm_service.dart';

//
Future<void> analyzerStarter({
  required SendPort sendPort,
  List<SidecarBaseConstructor> constructors = const [],
}) {
  return runZonedGuarded<Future<SidecarAnalyzer>>(() async {
    final container = ProviderContainer(
      overrides: [
        ruleConstructorProvider.overrideWithValue(constructors),
        rootUriProvider.overrideWithValue(Uri()),
      ],
      observers: [
        //
      ],
    );
    final service = container.read(sidecarAnalyzerCommServiceProvider);
    service.initialize(sendPort);
    final completer = Completer<RequestMessage>();
    final sub = container
        .read(analyzerCommunicationStream.stream)
        .listen((dynamic event) {
      if (event is String) {
        try {
          final json = jsonDecode(event) as Map<String, dynamic>;
          final msg = SidecarMessage.fromJson(json);
          if (msg is RequestMessage) {
            final request = msg.request;
            if (request is SetActiveRootRequest) completer.complete(msg);
          }
        } catch (e) {
          rethrow;
        }
      }
    });
    service.sendNotification(const InitCompleteNotification());

    final request = await completer.future;
    final root = (request.request as SetActiveRootRequest).root;

    container.updateOverrides([
      ruleConstructorProvider.overrideWithValue(constructors),
      rootUriProvider.overrideWithValue(root),
    ]);

    final analyzer = SidecarAnalyzer(container, initRequest: request);
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
      // while logger is the preferred form of printing logs
      // print() can be used as well. note that
      // any message that comes through here will be a simple raw string
      // and therefore will need to be wrapped with LogMessage.simple();
      // otherwise, SidecarRunner will not be able to parse the object correctly.

      final logRecord = LogRecord.simple(line);
      final message = SidecarMessage.log(logRecord);
      final json = message.toJson();
      final encodedJson = jsonEncode(json);
      return sendPort.send(encodedJson);
    },
  ))!;
}
