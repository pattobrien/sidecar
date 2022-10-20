import 'package:analyzer_plugin/channel/channel.dart';
import 'package:riverpod/riverpod.dart';

// should be overriden before plugin startup
final masterPluginChannelProvider = Provider<PluginCommunicationChannel>(
  (ref) => throw UnimplementedError(),
  name: 'masterPluginChannelProvider',
  dependencies: const [],
);
