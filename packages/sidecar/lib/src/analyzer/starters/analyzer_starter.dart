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
        //  cliOptionsProvider.overrideWithValue(cliOptions),
        // logDelegateProvider.overrideWithValue(logDelegate),
      ],
      observers: [
        //
      ],
    );
    return SidecarAnalyzer(container, sendPort: sendPort)..start();
  }, (error, stack) {
    throw UnimplementedError('$error $stack');
    sendPort.send(SidecarAnalyzerError(error, stack).toJson());
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
