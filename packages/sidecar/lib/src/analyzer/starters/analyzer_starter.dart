import 'dart:async';
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
  return runZonedGuarded<SidecarAnalyzer>(
    () {
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
    },
    (error, stack) {
      throw UnimplementedError('$error $stack');
      sendPort.send(SidecarAnalyzerError(error, stack).toJson());
    },
  )!;
}
