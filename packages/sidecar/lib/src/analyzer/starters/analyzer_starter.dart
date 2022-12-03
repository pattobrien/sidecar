import 'dart:async';
import 'dart:isolate';

import 'package:riverpod/riverpod.dart';

import '../../protocol/protocol.dart';
import '../../rules/rules.dart';
import '../providers/providers.dart';
import '../server/communication_channel.dart';
import '../sidecar_analyzer.dart';
import 'server_starter.dart';

/// Initializes the Sidecar analyzer from generated entrypoint
/// (see [analyzerIsolateStarter] for server-side equivalent)
Future<void> startAnalyzer(
  List<String> args,
  SendPort sendPort, {
  List<SidecarBaseConstructor> constructors = const [],
}) async {
  final root = Uri.parse(args.first);
  final channel = CommunicationChannel(sendPort);
  final container = ProviderContainer(overrides: [
    activeTargetRootProvider.overrideWithValue(root),
    communicationChannelProvider.overrideWithValue(channel),
    ruleConstructorProvider.overrideWithValue(constructors),
  ]);

  await runZonedGuarded<Future>(() async {
    final analyzer = container.read(sidecarAnalyzerProvider);
    return analyzer.setup();
  }, (error, stack) {
    final context = container.read(activePackageProvider);
    channel.handleError(context, error, stack);
    throw UnimplementedError('INVALID ERROR: $error $stack');
  }, zoneSpecification: ZoneSpecification(
    print: (self, parent, zone, line) {
      // while logger is the preferred form of printing logs
      // print() can be used as well. note that
      // any message that comes through here will be a simple raw string
      // and therefore will need to be wrapped with a LogRecord;
      // otherwise, SidecarRunner will not be able to parse the object correctly.
      final context = container.read(activePackageProvider);
      final log = LogRecord.fromAnalyzer(line, DateTime.now(),
          targetRoot: context.root, severity: LogSeverity.info);
      final msg = SidecarMessage.log(log);
      return sendPort.send(msg.toEncodedJson());
    },
  ));
}
