import 'dart:async';
import 'dart:isolate';

// ignore: implementation_imports
import 'package:analyzer_plugin/src/channel/isolate_channel.dart';
import 'package:riverpod/riverpod.dart';

import '../../utils/logger/logger.dart';
import '../server/log_delegate.dart';
import '../server/server.dart';

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
          logDelegateProvider.overrideWithValue(delegate),
        ],
      );
      logger.info('sidecar - plugin initialization....');
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
