// ignore_for_file: implementation_imports

import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:analyzer_plugin/src/channel/isolate_channel.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';

import '../../../sidecar.dart';
import '../../cli/options/cli_options.dart';
import '../../rules/rules.dart';
import '../../utils/logger/logger.dart';
import '../options_provider.dart';
import '../plugin/plugin.dart';
import '../server/log_delegate.dart';
import '../server/server.dart';

Future<void> startSidecarPlugin(
  SendPort sendPort,
  List<String> args, {
  required bool isMiddleman,
  List<SidecarBaseConstructor>? constructors,
}) async {
  final channel = PluginIsolateChannel(sendPort);
  final cliOptions =
      CliOptions.fromArgs(args, isPlugin: true, isMiddleman: isMiddleman);

  final LogDelegateBase delegate = PluginChannelDelegate(cliOptions, channel);
  final zoneSpec = ZoneSpecification(
    print: (self, parent, zone, line) {
      if (cliOptions.mode.isPlugin && cliOptions.isMiddlemanPlugin) {
        // final logFile = File(
        //     p.join(p.current, kDartTool, 'sidecar', 'logs', 'middleman.txt'));
        // if (!logFile.existsSync()) logFile.create(recursive: true);
        // logFile.writeAsString('\nMIDDLEMAN: $line');
        delegate.sidecarMessage('MIDDLEMAN: $line');
      } else if (cliOptions.mode.isPlugin && !cliOptions.isMiddlemanPlugin) {
        // final logFile =
        //     File(p.join(p.current, kDartTool, 'sidecar', 'logs', 'plugin.txt'));
        // if (!logFile.existsSync()) logFile.create(recursive: true);
        // logFile.writeAsString('\nISOLATE: $line');
        delegate.sidecarMessage('ISOLATE:   $line');
      }
    },
  );
  await runZonedGuarded<Future<void>>(
    () async {
      final container = ProviderContainer(
        overrides: [
          masterPluginChannelProvider.overrideWithValue(channel),
          ruleConstructorProvider.overrideWithValue(constructors ?? []),
          cliOptionsProvider.overrideWithValue(cliOptions),
          logDelegateProvider.overrideWithValue(delegate),
        ],
        observers: [PluginObserver(cliOptions, channel)],
      );

      try {
        delegate.sidecarVerboseMessage('sidecar - plugin initialization....');
        if (isMiddleman) {
          final middlemanPlugin = container.read(middlemanPluginProvider);
          middlemanPlugin.start(channel);
        } else {
          final plugin = container.read(pluginProvider);
          plugin.start(channel);
        }
      } catch (error, stackTrace) {
        delegate.sidecarError(error, stackTrace);
      }
    },
    delegate.sidecarError,
    zoneSpecification: zoneSpec,
  );
}
