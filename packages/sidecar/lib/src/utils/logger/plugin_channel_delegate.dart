import 'package:analyzer_plugin/channel/channel.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;

import '../../analyzer/results/analysis_result.dart';
import '../../cli/options/cli_options.dart';
import '../../utils/utils.dart';
import 'log_delegate_base.dart';

class PluginChannelDelegate implements LogDelegateBase {
  PluginChannelDelegate(this.options, this.channel);

  final CliOptions options;
  final PluginCommunicationChannel channel;

  @override
  void analysisResultError(LintResult result, Object err, StackTrace stack) {
    channel.sendError('analysisResultEr: ${result.rule.code} $err', stack);
  }

  @override
  void pluginInitializationFail(Object err, StackTrace stackTrace) {
    channel.sendError('pluginInitializationFail: $err', stackTrace);
  }

  @override
  void sidecarError(Object error, StackTrace stackTrace) {
    channel.sendError('sidecarError: $error', stackTrace);
  }

  @override
  void sidecarVerboseMessage(String message) {
    if (!options.isVerboseEnabled) return;
    channel.sendError('sidecarVerboseMessage: $message');
  }

  @override
  void pluginRestart() {
    channel.sendError('pluginRestart');
  }

  @override
  void sidecarMessage(String message) {
    channel.sendError('sidecarMessage: $message');
  }

  @override
  void analysisResults(String path, List<LintResult> results) {
    final errors = results.map((r) => r.toAnalysisError()).toList();
    channel.sendError('analysisResults: $path - ${results.length} ERRORS');
    final notif = plugin.AnalysisErrorsParams(path, errors).toNotification();
    channel.sendNotification(notif);
  }
}
