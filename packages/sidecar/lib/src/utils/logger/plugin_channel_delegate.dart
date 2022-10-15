import 'package:analyzer_plugin/channel/channel.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;

import '../../analyzer/results/analysis_result.dart';
import '../../cli/reports/file_stats.dart';
import '../../utils/utils.dart';
import 'log_delegate_base.dart';

class PluginChannelDelegate implements LogDelegateBase {
  const PluginChannelDelegate({
    required this.channel,
    this.isVerboseEnabled = false,
  });

  final bool isVerboseEnabled;
  final PluginCommunicationChannel channel;

  @override
  void analysisResultError(
      AnalysisResult result, Object err, StackTrace stackTrace) {
    channel.sendError(
        'analysisResultError: ${result.rule.code} $err', stackTrace);
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
    if (!isVerboseEnabled) return;
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
  void analysisResults(String path, List<AnalysisResult> results) {
    final errors = results
        .map((result) => result.toAnalysisError())
        .whereType<plugin.AnalysisError>()
        .toList();
    channel.sendError(
        'analysisResults delegate: $path - ${results.length} ERRORS');
    final notif = plugin.AnalysisErrorsParams(path, errors).toNotification();
    channel.sendNotification(notif);
  }

  @override
  void generateReport(Iterable<FileStats> reports) {
    // TODO: implement generateReport
  }
}
