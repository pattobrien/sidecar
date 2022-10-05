import 'dart:async';

import 'package:analyzer_plugin/channel/channel.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol.dart' as plugin;
import 'package:riverpod/riverpod.dart';

final pluginChannelProvider = Provider<plugin.PluginCommunicationChannel>(
    (ref) => throw UnimplementedError());

final pluginStreamProvider = StreamProvider<plugin.Request>((ref) {
  final controller = StreamController<plugin.Request>();

  ref.read(pluginChannelProvider).listen(controller.add,
      onDone: controller.close, onError: controller.close);

  return controller.stream;
});
