// ignore_for_file: implementation_imports

import 'dart:io';
import 'dart:isolate';

import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';
import 'package:sidecar_analyzer_plugin_core/src/context_services/context_services.dart';
import 'package:sidecar_analyzer_plugin_core/src/runner/sidecar_runner.dart';
import 'package:analyzer_plugin/src/channel/isolate_channel.dart';

import 'log_delegate/log_delegate.dart';
import 'plugin/plugin.dart';

Future<void> startSidecarPlugin(
  SendPort sendPort,
  List<String> args,
  bool isPlugin,
  Map<Id, CodeEditConstructor> codeEditConstructors,
  Map<Id, LintRuleConstructor> lintRuleConstructors,
) async {
  LogDelegateBase delegate;
  SidecarAnalyzerMode mode;

  if (args.contains('--debug')) {
    delegate = DebuggerLogDelegate();
    mode = SidecarAnalyzerMode.debug;
  } else if (isPlugin) {
    delegate = EmptyDelegate();
    mode = SidecarAnalyzerMode.plugin;
  } else {
    delegate = DebuggerLogDelegate();
    mode = SidecarAnalyzerMode.cli;
  }

  final pluginChannel = PluginIsolateChannel(sendPort);

  final ref = ProviderContainer(
    overrides: [
      logDelegateProvider.overrideWithValue(delegate),
      sidecarAnalyzerMode.overrideWithValue(mode),
      pluginChannelProvider.overrideWithValue(pluginChannel),
      lintRuleConstructorProvider.overrideWithValue(lintRuleConstructors),
      codeEditConstructorProvider.overrideWithValue(codeEditConstructors),
    ],
  );

  final plugin = ref.read(pluginProvider);
  try {
    if (mode.isDebug) {
      print('debug initialization started');
      final runner = SidecarRunner(plugin, Directory.current);
      await runner.initialize();
      print('debug initialization complete');
    } else if (mode.isCli) {
      Logger.log('cli initialization started');
      final runner = SidecarRunner(plugin, Directory.current);
      await runner.initialize();
      await runner.server.initializationCompleter.future;
      Logger.log('cli initialization ended');
      exit(0);
    } else {
      // mode is plugin
      // ServerPluginStarter(plugin).start(sendPort);
      plugin.start(pluginChannel);
    }
  } catch (error, stackTrace) {
    delegate.sidecarError(error, stackTrace);
  }
}
