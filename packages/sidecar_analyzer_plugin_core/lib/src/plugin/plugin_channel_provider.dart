import 'package:analyzer_plugin/channel/channel.dart' as plugin;
import 'package:riverpod/riverpod.dart';

final masterPluginChannelProvider = Provider<plugin.PluginCommunicationChannel>(
    (ref) => throw UnimplementedError());
