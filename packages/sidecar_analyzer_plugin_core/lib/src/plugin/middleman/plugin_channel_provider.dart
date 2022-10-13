import 'package:analyzer_plugin/channel/channel.dart' as plugin;
import 'package:riverpod/riverpod.dart';

// should be overriden before plugin startup
final masterPluginChannelProvider = Provider<plugin.PluginCommunicationChannel>(
  (ref) => throw UnimplementedError(),
  dependencies: const [],
);
