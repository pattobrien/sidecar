import 'dart:async';
import 'dart:isolate';

// ignore: implementation_imports
import 'package:analyzer_plugin/src/channel/isolate_channel.dart';
import 'package:riverpod/riverpod.dart';

import '../../utils/logger/logger.dart';
import '../server.dart';
import '../server_providers.dart';

/// Run Sidecar via analyzer_plugin package.
///
/// This function is called from tools/analyzer_plugin/bin/plugin.dart
Future<void> startSidecarPlugin(
  SendPort sendPort,
  List<String> args,
) async {
  final channel = PluginIsolateChannel(sendPort);

  final LogDelegateBase delegate = PluginChannelDelegate(channel);
  runZonedGuarded(
    () {
      final container = ProviderContainer(
        overrides: [
          analyzerPluginChannelProvider.overrideWithValue(channel),
        ],
      );
      // logger.info('sidecar - plugin initialization....');
      final analyzerPlugin = container.read(analyzerPluginProvider);
      analyzerPlugin.start(channel);
    },
    delegate.sidecarError,
    zoneSpecification: ZoneSpecification(
      print: (self, parent, zone, line) {
        delegate.sidecarLog(line);
      },
    ),
  );
}
