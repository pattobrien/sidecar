// ignore_for_file: implementation_imports

import 'dart:isolate';

import 'package:analyzer_plugin/src/channel/isolate_channel.dart';
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

  final LogDelegateBase logger = PluginChannelDelegate(cliOptions, channel);

  final container = ProviderContainer(
    overrides: [
      masterPluginChannelProvider.overrideWithValue(channel),
      ruleConstructorProvider.overrideWithValue(constructors ?? []),
      cliOptionsProvider.overrideWithValue(cliOptions),
      logDelegateProvider.overrideWithValue(logger),
    ],
    observers: [PluginObserver(cliOptions, channel)],
  );

  try {
    logger.sidecarVerboseMessage('sidecar - plugin initialization....');
    if (isMiddleman) {
      final middlemanPlugin = container.read(middlemanPluginProvider);
      middlemanPlugin.start(channel);
    } else {
      final plugin = container.read(pluginProvider);
      plugin.start(channel);
    }
  } catch (error, stackTrace) {
    logger.sidecarError(error, stackTrace);
  }
}
