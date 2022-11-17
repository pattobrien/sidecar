import 'package:analyzer_plugin/channel/channel.dart';

import '../../protocol/protocol.dart';
import '../../utils/utils.dart';
import 'log_delegate_base.dart';

class PluginChannelDelegate implements LogDelegateBase {
  PluginChannelDelegate(this.channel);

  final PluginCommunicationChannel channel;

  void _log(String message) {
    // const url = '/Users/pattobrien/Development/sidecar';
    // final logFile =
    //     io.File(p.join(url, '.sidecar', 'sidecar_logs', 'middleman.txt'));
    // // if (!logFile.existsSync()) logFile.create(recursive: true);
    // logFile.writeAsStringSync('\nMIDDLEMANDELEGATE: $message',
    //     mode: io.FileMode.append, flush: true);
  }

  @override
  void analysisResultError(LintResult result, Object err, StackTrace stack) {
    channel.sendError('analysisResultEr: ${result.rule.code} $err', stack);
    _log('analysisResultEr: ${result.rule.code} $err $stack');
  }

  @override
  void sidecarError(Object error, StackTrace stackTrace) {
    channel.sendError('sidecarError: $error', stackTrace);
    _log('sidecarError: $error $stackTrace');
  }

  @override
  void sidecarVerboseMessage(String message) {
    // if (!options.isVerboseEnabled) return;
    channel.sendError('sidecarVerboseMessage: $message');
    _log('sidecarVerboseMessage: $message');
  }

  @override
  void sidecarMessage(String message) {
    channel.sendError(message);
    _log('sidecarMessage: $message');
  }

  @override
  void analysisResults(String path, List<LintResult> results) {
    _log('analysisResults: $path $results');
    // final errors = results.map((r) => r.toAnalysisError()).toList();
    // channel.sendError('analysisResults: $path - ${results.length} ERRORS');
    // final notif = plugin.AnalysisErrorsParams(path, errors).toNotification();
    // channel.sendNotification(notif);
  }

  @override
  void sidecarLog(String message) {
    channel.sendError(message);
    _log('sidecarLog: $message');
  }
}
