import 'package:analyzer_plugin/channel/channel.dart';
import 'package:riverpod/riverpod.dart';

// should be overriden before plugin startup
final analyzerPluginChannelProvider = Provider<PluginCommunicationChannel>(
  (ref) => throw UnimplementedError(),
  name: 'analyzerPluginChannelProvider',
  dependencies: const [],
);
