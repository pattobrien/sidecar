import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:riverpod/riverpod.dart';

import '../../protocol/protocol.dart';
import '../../rules/rules.dart';
import '../plugin/rule_constructors_provider.dart';
import '../plugin/sidecar_analyzer.dart';

SidecarAnalyzer analyzerStarter({
  required SendPort sendPort,
  List<SidecarBaseConstructor> constructors = const [],
}) {
  return runZonedGuarded<SidecarAnalyzer>(() {
    final container = ProviderContainer(
      overrides: [
        ruleConstructorProvider.overrideWithValue(constructors),
      ],
      observers: [
        //
      ],
    );
    return SidecarAnalyzer(container, sendPort: sendPort)..start();
  }, (error, stack) {
    final msg = ErrorMessage(error, stack);
    final json = msg.toJson();
    final encodedJson = jsonEncode(json);
    sendPort.send(encodedJson);
    throw UnimplementedError('$error $stack');
  }, zoneSpecification: ZoneSpecification(
    print: (self, parent, zone, line) {
      try {
        final json = jsonDecode(line) as Map<String, dynamic>;
        final msg = SidecarMessage.fromJson(json);
        if (msg is LogMessage) {
          return sendPort.send(line);
        }
        throw UnimplementedError(
            'unexpected log message format: ${msg.runtimeType}');
      } catch (e, stack) {
        throw UnimplementedError('unexpected analyzer zone error: $e, $stack');
      }
    },
  ))!;
}
