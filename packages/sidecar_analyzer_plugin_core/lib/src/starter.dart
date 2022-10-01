// ignore_for_file: implementation_imports

import 'dart:io';
import 'dart:isolate';

import 'package:analyzer_plugin/src/channel/isolate_channel.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';

import 'plugin/plugin.dart';
import 'runner/sidecar_runner.dart';
import 'services/log_delegate/log_delegate.dart';
import 'services/rule_constructor_provider.dart';

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
    delegate = const DebuggerLogDelegate();
    mode = SidecarAnalyzerMode.debug;
  } else if (isPlugin) {
    delegate = const EmptyDelegate();
    mode = SidecarAnalyzerMode.plugin;
  } else {
    delegate = const DebuggerLogDelegate();
    mode = SidecarAnalyzerMode.cli;
  }

  final pluginChannel = PluginIsolateChannel(sendPort);
  final ref = ProviderContainer(
    overrides: [
      logDelegateProvider.overrideWithValue(delegate),
      sidecarAnalyzerMode.overrideWithValue(mode),
      pluginChannelProvider.overrideWithValue(pluginChannel),
      ruleConstructorProvider.overrideWithValue(
        {...lintRuleConstructors, ...codeEditConstructors},
      ),
    ],
  );

  final plugin = ref.read(pluginProvider);
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
      plugin.start(pluginChannel);
    }
  } catch (error, stackTrace) {
    delegate.sidecarError(error, stackTrace);
  }
}
