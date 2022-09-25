import 'package:analyzer_plugin/channel/channel.dart' as plugin;
import 'package:riverpod/riverpod.dart';

import '../log_delegate/log_delegate.dart';

final pluginChannelProvider = Provider<plugin.PluginCommunicationChannel>(
    (ref) => throw UnimplementedError());

final logDelegateProvider =
    Provider<LogDelegateBase>((ref) => throw UnimplementedError());
