// ignore_for_file: implementation_imports

import 'dart:io';
import 'dart:isolate';

import 'package:analyzer_plugin/src/channel/isolate_channel.dart';
import 'package:cli_util/cli_logging.dart';
import 'package:riverpod/riverpod.dart';

import '../../sidecar.dart';
import '../cli/options/cli_options.dart';
import '../rules/rules.dart';
import '../utils/logger/cli_observer.dart';
import '../utils/logger/logger.dart';
import 'options_provider.dart';
import 'plugin/plugin.dart';
import 'server/log_delegate.dart';
import 'server/runner/runner.dart';
import 'server/server.dart';

Future<void> startSidecarPlugin(
  SendPort sendPort,
  List<String> args, {
  List<SidecarBaseConstructor>? constructors,
  required bool isMiddleman,
  required bool isPlugin,
}) async {
  final pluginChannel = PluginIsolateChannel(sendPort);
  final cliOptions = CliOptions.fromArgs(args, isPlugin: isPlugin);

  late final LogDelegateBase logger;

  switch (cliOptions.mode) {
    case SidecarAnalyzerMode.debug:
      logger = DebuggerLogDelegate(cliOptions);
      break;
    case SidecarAnalyzerMode.cli:
      logger = DebuggerLogDelegate(cliOptions);
      break;
    case SidecarAnalyzerMode.plugin:
      logger = PluginChannelDelegate(cliOptions, pluginChannel);
      break;
    default:
      // throw StateError('Logger cant be initialized');
      logger = DebuggerLogDelegate(cliOptions);
      break;
  }

  final container = ProviderContainer(
    overrides: [
      masterPluginChannelProvider.overrideWithValue(pluginChannel),
      ruleConstructorProvider.overrideWithValue(constructors ?? []),
      cliOptionsProvider.overrideWithValue(cliOptions),
      logDelegateProvider.overrideWithValue(logger),
    ],
    observers: [
      if (cliOptions.mode.isPlugin)
        PluginObserver(cliOptions, pluginChannel)
      else
        CliObserver(cliOptions)
    ],
  );

  try {
    // container.listen<SidecarAnalyzerPlugin>(pluginProvider, (_, next) async {
    //   final runner = SidecarRunner(next, Directory.current);
    //   await runner.initialize();
    //   if (cliOptions.mode.isCli) {
    //     final ansi = Ansi(true);
    //     logger.sidecarVerboseMessage(
    //         '${ansi.cyan} sidecar - cli initialization....${ansi.none}');
    //     await runner.initialize();
    //     await runner.server.initializationCompleter.future;
    //     exit(0);
    //   } else if (cliOptions.mode.isDebug) {
    //     logger
    //         .sidecarVerboseMessage('sidecar - debug initialization started...');
    //     final plugin = container.read(pluginProvider);
    //     final runner = SidecarRunner(plugin, Directory.current);
    //     await runner.initialize();
    //   } else if (cliOptions.mode.isPlugin) {
    //     if (isMiddleman) {
    //       final middlemanPlugin = container.read(middlemanPluginProvider);
    //       middlemanPlugin.start(pluginChannel);
    //     } else {
    //       final plugin = container.read(pluginProvider);
    //       plugin.start(pluginChannel);
    //     }
    //   }
    // });

    try {
      if (cliOptions.mode.isDebug) {
        logger
            .sidecarVerboseMessage('sidecar - debug initialization started...');
        final plugin = container.read(pluginProvider);
        final runner = SidecarRunner(plugin, Directory.current);
        await runner.initialize();
      } else if (cliOptions.mode.isCli) {
        final ansi = Ansi(true);
        logger.sidecarVerboseMessage(
            '${ansi.cyan}sidecar - cli initialization....${ansi.none}');
        final plugin = container.read(pluginProvider);
        final runner = SidecarRunner(plugin, Directory.current);
        await runner.initialize();
        await runner.server.initializationCompleter.future;
        exit(0);
      } else {
        logger.sidecarVerboseMessage('sidecar - plugin initialization....');
        if (isMiddleman) {
          final middlemanPlugin = container.read(middlemanPluginProvider);
          middlemanPlugin.start(pluginChannel);
        } else {
          final plugin = container.read(pluginProvider);
          plugin.start(pluginChannel);
        }
      }
    } catch (error, stackTrace) {
      logger.sidecarError(error, stackTrace);
    }
  } catch (error, stackTrace) {
    logger.sidecarError(error, stackTrace);
  }
}
