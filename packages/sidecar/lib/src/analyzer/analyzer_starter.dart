import 'dart:async';
import 'dart:isolate';

import 'package:logging/logging.dart' hide LogRecord;
import 'package:riverpod/riverpod.dart';

import '../rules/rules.dart';
import '../server/communication_channel.dart';
import '../server/starters/server_starter.dart';
import 'analyzer_logger.dart';
import 'providers/providers.dart';
import 'sidecar_analyzer.dart';

/// Initializes the Sidecar analyzer from generated entrypoint
///
/// See [analyzerIsolateStarter] for server-side equivalent.
Future<void> startAnalyzer(
  List<String> args,
  SendPort sendPort, {
  List<SidecarBaseConstructor> constructors = const [],
}) async {
  final root = Uri.file(args.first);
  final channel = CommunicationChannel(sendPort);
  final container = ProviderContainer(overrides: [
    activeTargetRootProvider.overrideWithValue(root),
    communicationChannelProvider.overrideWithValue(channel),
    ruleConstructorProvider.overrideWithValue(constructors),
    loggerProvider.overrideWith((ref) {
      final logger = Logger('sidecar-analyzer');
      final callback = logger.initialize(root, constructors);
      ref.onCancel(callback);
      return logger;
    }),
  ]);
  final logger = container.read(loggerProvider);

  await runZonedGuarded<Future>(() async {
    final analyzer = container.read(sidecarAnalyzerProvider);
    return analyzer.setup();
  }, (error, stack) {
    final context = container.read(activePackageProvider);
    logger.severe(error, null, stack);
    channel.handleError(context, error, stack);
    throw UnimplementedError('INVALID ERROR: $error $stack');
  }, zoneSpecification: ZoneSpecification(
    print: (self, parent, zone, line) {
      logger.info(line);
    },
  ));
}
