import 'dart:async';
import 'dart:isolate';

import 'package:riverpod/riverpod.dart';

import '../../protocol/logging/log_record.dart';
import '../../protocol/protocol.dart';
import '../../rules/rules.dart';
import '../plugin/active_package_provider.dart';
import '../plugin/communication_channel.dart';
import '../plugin/rule_constructors_provider.dart';
import '../plugin/sidecar_analyzer.dart';

Future<void> analyzerStarter(
  List<String> args,
  SendPort sendPort, {
  List<SidecarBaseConstructor> constructors = const [],
}) async {
  final root = Uri.parse(args.first);
  final channel = CommunicationChannel(sendPort);
  final container = ProviderContainer(overrides: [
    activePackageRootProvider.overrideWithValue(root),
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
          root: context.packageRoot, severity: LogSeverity.info);
      final msg = SidecarMessage.log(log);
      return sendPort.send(msg.toEncodedJson());
    },
  ));
}
