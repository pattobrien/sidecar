import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:analyzer_plugin/channel/channel.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';

import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;

import '../plugin/plugin.dart';

final errorComposerProvider = Provider.family<ErrorComposer, ContextRoot>(
  (ref, contextRoot) => ErrorComposer(
    channel: ref.watch(pluginChannelProvider)!,
    contextRoot: contextRoot,
  ),
);

class ErrorComposer {
  ErrorComposer({
    required this.channel,
    required this.contextRoot,
  });

  final PluginCommunicationChannel channel;
  final ContextRoot contextRoot;

  final _errors = <YamlSourceError>[];

  void addErrors(List<YamlSourceError> errors) => _errors.addAll(errors);

  void flush() {
    final analysisErrors = _errors.map((e) => e.toAnalysisError()).toList();

    final path = contextRoot.optionsFile?.path;
    if (path == null) return;
    final response =
        plugin.AnalysisErrorsParams(path, analysisErrors).toNotification();
    channel.sendNotification(response);
    _errors.clear();
  }
}
