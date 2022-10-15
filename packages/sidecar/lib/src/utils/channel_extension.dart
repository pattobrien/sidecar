import 'package:analyzer_plugin/channel/channel.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;

extension PluginCommunicationChannelX on plugin.PluginCommunicationChannel {
  void sendError(Object message, [StackTrace? stackTrace]) {
    sendNotification(
      plugin.PluginErrorParams(
        false,
        message.toString(),
        stackTrace.toString(),
      ).toNotification(),
    );
  }
}
