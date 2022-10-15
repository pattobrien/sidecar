// ignore_for_file: implementation_imports

import 'dart:io';
import 'dart:isolate';

import 'package:analyzer_plugin/src/channel/isolate_channel.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';

import 'plugin/analyzer/analyzer.dart';
import 'plugin/middleman/middleman.dart';
import 'plugin/plugin.dart';
import 'runner/sidecar_runner.dart';
import 'services/services.dart';

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
    observers: [PluginObserver(delegate, isMiddleman: isMiddleman)],
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

class PluginObserver extends ProviderObserver {
  PluginObserver(this.delegate, {required this.isMiddleman});

  final LogDelegateBase delegate;
  final bool isMiddleman;

  String get header => isMiddleman ? 'MIDDLEMAN:' : 'ISOLATE:';

  @override
  void didAddProvider(
    ProviderBase provider,
    Object? value,
    ProviderContainer container,
  ) {
    delegate.sidecarMessage(
        '$header didAddProvider     ${provider.name}} ${value.toString()}}');
  }

  /// A provider emitted an error, be it by throwing during initialization
  /// or by having a [Future]/[Stream] emit an error
  @override
  void providerDidFail(
    ProviderBase provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    delegate.sidecarMessage(
        '$header providerDidFail    ${provider.name}} ${error.toString()} ${stackTrace.toString()}');
  }

  /// Called my providers when they emit a notification.
  ///
  /// - [newValue] will be `null` if the provider threw during initialization.
  /// - [previousValue] will be `null` if the previous build threw during initialization.
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    delegate.sidecarMessage(
        '$header didUpdateProvider  ${provider.name}} ${previousValue.toString()} || ${newValue.toString()}');
  }

  /// A provider was disposed
  @override
  void didDisposeProvider(
    ProviderBase provider,
    ProviderContainer container,
  ) {
    delegate.sidecarMessage('$header didDisposeProvider ${provider.name}}');
  }
}
