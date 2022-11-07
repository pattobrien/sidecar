// ignore_for_file: implementation_imports

import 'dart:async';
import 'dart:isolate';

import 'package:analyzer_plugin/src/channel/isolate_channel.dart';
import 'package:riverpod/riverpod.dart';

import '../../cli/options/cli_options.dart';
import '../../utils/logger/logger.dart';
import '../options_provider.dart';
import '../server/server.dart';

Future<void> startSidecarPlugin(
  SendPort sendPort,
  List<String> args,
) async {
  final channel = PluginIsolateChannel(sendPort);
  final cliOptions = CliOptions.fromArgs(args, isPlugin: true);

  final LogDelegateBase delegate = PluginChannelDelegate(cliOptions, channel);
  await runZonedGuarded<Future<void>>(
    () async {
      final container = ProviderContainer(
        overrides: [
          masterPluginChannelProvider.overrideWithValue(channel),
          cliOptionsProvider.overrideWithValue(cliOptions),
          // logDelegateProvider.overrideWithValue(delegate),
        ],
        observers: [
          // PluginObserver(cliOptions, channel),
        ],
      );

      try {
        logger.info('sidecar - plugin initialization....');
        final middlemanPlugin = container.read(middlemanPluginProvider);
        middlemanPlugin.start(channel);
      } catch (error, stackTrace) {
        delegate.sidecarError(error, stackTrace);
      }
    },
    delegate.sidecarError,
    zoneSpecification: ZoneSpecification(
      print: (self, parent, zone, line) {
        // delegate.sidecarLog(line);
      },
    ),
  );
}
