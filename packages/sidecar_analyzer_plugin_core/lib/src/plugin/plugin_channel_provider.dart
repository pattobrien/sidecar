import 'dart:async';

import 'package:analyzer_plugin/channel/channel.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol.dart' as plugin;
import 'package:riverpod/riverpod.dart';

import '../services/log_delegate/log_delegate_base.dart';

final masterPluginChannelProvider = Provider<plugin.PluginCommunicationChannel>(
    (ref) => throw UnimplementedError());

// final pluginStreamProvider = StreamProvider<plugin.Request>((ref) {
//   final controller = StreamController<plugin.Request>();

//   ref.watch(pluginChannelProvider).listen(controller.add,
//       onDone: controller.close, onError: controller.close);
//   ref.onDispose(() {
//     ref
//         .read(logDelegateProvider)
//         .sidecarMessage('pluginStreamProvider DISPOSED');
//   });
//   return controller.stream;
// });
