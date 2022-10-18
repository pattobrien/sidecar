// ignore_for_file: implementation_imports

import 'dart:io';
import 'dart:isolate';

import 'package:analyzer_plugin/src/channel/isolate_channel.dart';
import 'package:cli_util/cli_logging.dart';
import 'package:riverpod/riverpod.dart';

import '../cli/options/cli_options.dart';
import '../rules/rules.dart';
import '../utils/logger/logger.dart';
import 'options_provider.dart';
import 'plugin/plugin.dart';
import 'server/runner/runner.dart';
import 'server/server.dart';

Future<void> startSidecarPlugin(
  SendPort sendPort,
  List<String> args, {
  List<SidecarBaseConstructor>? constructors,
  required bool isMiddleman,
  required bool isPlugin,
}) async {
  LogDelegateBase delegate;
  SidecarAnalyzerMode mode;
  final newArgs = [
    ...args,
    if (!isPlugin && args.contains('--debug')) '--debug' else '--cli'
  ];
  final pluginChannel = PluginIsolateChannel(sendPort);
  final cliOptions = CliOptions.fromArgs(newArgs);

  final ansi = Ansi(true);
  if (newArgs.contains('--debug')) {
    delegate = DebuggerLogDelegate(cliOptions: cliOptions);
    mode = SidecarAnalyzerMode.debug;
    delegate.sidecarVerboseMessage('sidecar - debug initialization started...');
  } else if (isPlugin) {
    delegate = PluginChannelDelegate(channel: pluginChannel);
    mode = SidecarAnalyzerMode.plugin;
  } else {
    delegate = DebuggerLogDelegate(cliOptions: cliOptions);
    mode = SidecarAnalyzerMode.cli;
    delegate.sidecarVerboseMessage(
        '${ansi.cyan} sidecar - cli initialization started...${ansi.none}');
  }

  delegate.sidecarVerboseMessage('ISMIDDLEMAN: $isMiddleman');
  final ref = ProviderContainer(
    overrides: [
      logDelegateProvider.overrideWithValue(delegate),
      sidecarAnalyzerMode.overrideWithValue(mode),
      masterPluginChannelProvider.overrideWithValue(pluginChannel),
      ruleConstructorProvider.overrideWithValue(constructors ?? []),
      cliOptionsProvider.overrideWithValue(cliOptions),
    ],
    observers: [
      PluginObserver(delegate, isMiddleman: isMiddleman),
    ],
  );

  try {
    if (mode.isDebug) {
      // delegate
      //     .sidecarVerboseMessage('sidecar - debug initialization started...');
      final plugin = ref.read(pluginProvider);
      final runner = SidecarRunner(plugin, Directory.current);
      await runner.initialize();
    } else if (mode.isCli) {
      final plugin = ref.read(pluginProvider);
      final runner = SidecarRunner(plugin, Directory.current);
      delegate.sidecarVerboseMessage(
          '${ansi.cyan} sidecar - cli initialization....${ansi.none}');
      await runner.initialize();
      await runner.server.initializationCompleter.future;
      exit(0);
    } else {
      if (isMiddleman) {
        final middlemanPlugin = ref.read(middlemanPluginProvider);
        middlemanPlugin.start(pluginChannel);
      } else {
        final plugin = ref.read(pluginProvider);
        plugin.start(pluginChannel);
      }
    }
  } catch (error, stackTrace) {
    delegate.sidecarError(error, stackTrace);
  }
}
