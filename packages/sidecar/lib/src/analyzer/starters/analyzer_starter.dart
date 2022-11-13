import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:riverpod/riverpod.dart';

import '../../protocol/logging/log_record.dart';
import '../../protocol/protocol.dart';
import '../../rules/rules.dart';
import '../plugin/active_package_provider.dart';
import '../plugin/rule_constructors_provider.dart';
import '../plugin/sidecar_analyzer.dart';
import '../plugin/sidecar_analyzer_comm_service.dart';

Future<void> analyzerStarter({
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
    final service = container.read(sidecarAnalyzerCommServiceProvider);
    service.initialize(sendPort);
    // final completer = Completer<RequestMessage>();
    // final sub = container
    //     .read(analyzerCommunicationStream.stream)
    //     .listen((dynamic event) {
    //   if (event is String) {
    //     try {
    //       final json = jsonDecode(event) as Map<String, dynamic>;
    //       final msg = SidecarMessage.fromJson(json);
    //       if (msg is RequestMessage) {
    //         final request = msg.request;
    //         if (request is SetActivePackageRequest) completer.complete(msg);
    //       }
    //     } catch (e) {
    //       rethrow;
    //     }
    //   }
    // });
    service.sendNotification(const InitCompleteNotification());

    final activePackage = await container.read(activePackageProvider.future);

    // final message = await completer.future;

    // final analyzer = SidecarAnalyzer(container, constructors: constructors);
    final analyzer = container.read(sidecarAnalyzerProvider);
    // await sub.cancel();
    // await analyzer.handleRequest(message);
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
