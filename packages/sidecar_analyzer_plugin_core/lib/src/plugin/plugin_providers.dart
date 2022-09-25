import 'package:analyzer_plugin/channel/channel.dart' as plugin;
import 'package:riverpod/riverpod.dart';

import '../log_delegate/log_delegate.dart';

final pluginChannelProvider =
    StateProvider<plugin.PluginCommunicationChannel?>((ref) => null);

final logDelegateProvider =
    Provider<LogDelegateBase>((ref) => throw UnimplementedError());
