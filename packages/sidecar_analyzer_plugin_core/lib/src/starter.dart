// ignore_for_file: implementation_imports

import 'dart:io';
import 'dart:isolate';

import 'package:analyzer_plugin/src/channel/isolate_channel.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';

import 'plugin/middleman_plugin.dart';
import 'plugin/plugin.dart';
import 'plugin/plugin_from_path.dart';
import 'runner/sidecar_runner.dart';
import 'services/log_delegate/log_delegate.dart';
import 'services/rule_constructor_provider.dart';

Future<void> startSidecarPlugin(
  SendPort sendPort,
  List<String> args, {
  List<SidecarBaseConstructor>? constructors,
  required bool isMiddleman,
  required bool isPlugin,
  required bool isInitializedFromPath,
}) async {
  LogDelegateBase delegate;
  SidecarAnalyzerMode mode;

  final pluginChannel = PluginIsolateChannel(sendPort);

  if (args.contains('--debug')) {
    delegate = const DebuggerLogDelegate();
    mode = SidecarAnalyzerMode.debug;
  } else if (isPlugin) {
    delegate = PluginChannelDelegate(channel: pluginChannel);
    mode = SidecarAnalyzerMode.plugin;
  } else {
    delegate = const DebuggerLogDelegate();
    mode = SidecarAnalyzerMode.cli;
  }
  delegate.sidecarMessage('ISMIDDLEMAN: $isMiddleman');
  final ref = ProviderContainer(
    overrides: [
      logDelegateProvider.overrideWithValue(delegate),
      sidecarAnalyzerMode.overrideWithValue(mode),
      masterPluginChannelProvider.overrideWithValue(pluginChannel),
      ruleConstructorProvider.overrideWithValue(constructors ?? []),
      isPluginFromPath.overrideWithValue(isInitializedFromPath),
    ],
  );

  final plugin = ref.read(pluginProvider);
  final middlemanPlugin = ref.read(middlemanPluginProvider);

  try {
    if (mode.isDebug) {
      delegate.sidecarMessage('sidecar - debug initialization started...');
      final runner = SidecarRunner(plugin, Directory.current);
      await runner.initialize();
    } else if (mode.isCli) {
      delegate.sidecarMessage('sidecar - cli initialization started...');
      final runner = SidecarRunner(plugin, Directory.current);
      await runner.initialize();
      await runner.server.initializationCompleter.future;
      exit(0);
    } else {
      if (isMiddleman) {
        middlemanPlugin.start(pluginChannel);
      } else {
        plugin.start(pluginChannel);
      }
    }
  } catch (error, stackTrace) {
    delegate.sidecarError(error, stackTrace);
  }
}
