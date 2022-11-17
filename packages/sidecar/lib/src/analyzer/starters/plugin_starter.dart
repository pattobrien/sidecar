import 'dart:async';
import 'dart:isolate';

// ignore: implementation_imports
import 'package:analyzer_plugin/src/channel/isolate_channel.dart';
import 'package:riverpod/riverpod.dart';

import '../../cli/options/cli_options.dart';
import '../../reports/plugin_reporter.dart';
import '../../utils/logger/logger.dart';
import '../options_provider.dart';
import '../server/log_delegate.dart';
import '../server/server.dart';

Future<void> startSidecarPlugin(
  SendPort sendPort,
  List<String> args,
) async {
  final channel = PluginIsolateChannel(sendPort);
  final cliOptions = CliOptions.fromArgs(args, isPlugin: true);

  final LogDelegateBase delegate = PluginChannelDelegate(cliOptions, channel);
  runZonedGuarded(
    () {
      final container = ProviderContainer(
        overrides: [
          analyzerPluginChannelProvider.overrideWithValue(channel),
          cliOptionsProvider.overrideWithValue(cliOptions),
          logDelegateProvider.overrideWithValue(delegate),
        ],
      );
      logger.info('sidecar - plugin initialization....');
      final analyzerPlugin = container.read(analyzerPluginProvider);
      analyzerPlugin.start(channel);
    },
    delegate.sidecarError,
    zoneSpecification: ZoneSpecification(
      print: (self, parent, zone, line) {
        delegate.sidecarLog(line);
      },
    ),
  );
}
