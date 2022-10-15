// ignore_for_file: implementation_imports

import 'dart:io';
import 'dart:isolate';

import 'package:analyzer_plugin/src/channel/isolate_channel.dart';
import 'package:riverpod/riverpod.dart';

import '../rules/rules.dart';
import '../utils/logger/logger.dart';
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
    ],
    observers: [
      PluginObserver(delegate, isMiddleman: isMiddleman),
    ],
  );

  try {
    if (mode.isDebug) {
      delegate.sidecarMessage('sidecar - debug initialization started...');
      final plugin = ref.read(pluginProvider);
      final runner = SidecarRunner(plugin, Directory.current);
      await runner.initialize();
    } else if (mode.isCli) {
      delegate.sidecarMessage('sidecar - cli initialization started...');
      final plugin = ref.read(pluginProvider);
      final runner = SidecarRunner(plugin, Directory.current);
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
