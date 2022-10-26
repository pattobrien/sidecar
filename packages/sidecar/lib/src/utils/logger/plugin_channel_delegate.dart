import 'package:analyzer_plugin/channel/channel.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:riverpod/riverpod.dart';

import '../../analyzer/options_provider.dart';
import '../../analyzer/results/analysis_result.dart';
import '../../analyzer/server/server.dart';
import '../../cli/options/cli_options.dart';
import '../../cli/reports/file_stats.dart';
import '../../utils/utils.dart';
import 'log_delegate_base.dart';

class PluginChannelDelegate implements LogDelegateBase {
  PluginChannelDelegate(this.options, this.channel);

  // final bool isVerboseEnabled;
  final CliOptions options;
  final PluginCommunicationChannel channel;

  @override
  void analysisResultError(
      LintAnalysisResult result, Object err, StackTrace stackTrace) {
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
  void analysisResults(String path, List<LintAnalysisResult> results) {
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
