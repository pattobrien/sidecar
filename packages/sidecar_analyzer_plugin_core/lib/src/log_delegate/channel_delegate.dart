import 'package:analyzer_plugin/channel/channel.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/src/models/lint_rule.dart';
import 'package:sidecar/src/models/detected_lint.dart';
import 'package:sidecar/src/models/code_edit.dart';
import 'package:sidecar_analyzer_plugin_core/sidecar_analyzer_plugin_core.dart';

class ChannelDelegate implements LogDelegateBase {
  ChannelDelegate({required this.ref});

  final Ref ref;
  // final PluginCommunicationChannel channel;
  @override
  void editMessage(CodeEdit edit, String message) {
    // TODO: implement editMessage
  }

  @override
  void lintError(LintRule lint, Object err, String stackTrace) {
    // TODO: implement lintError
  }

  @override
  void lintMessage(DetectedLint lint, String message) {
    // TODO: implement lintMessage
  }

  @override
  void pluginInitializationFail(Object err, StackTrace stackTrace) {
    // TODO: implement pluginInitializationFail
  }

  @override
  void pluginRestart() {
    // TODO: implement pluginRestart
  }

  @override
  void sidecarError(Object error, StackTrace stackTrace) {
    // TODO: implement sidecarError
  }

  @override
  void sidecarMessage(String message) {
    // TODO: implement sidecarMessage
  }

  @override
  void sidecarVerboseMessage(String message) {
    // TODO: implement sidecarVerboseMessage
  }
}
