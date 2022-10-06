// ignore_for_file: implementation_imports

import 'dart:io';

import 'package:analyzer/instrumentation/noop_service.dart';
import 'package:analyzer_plugin/protocol/protocol.dart';
import 'package:analyzer_plugin/src/channel/isolate_channel.dart' as plugin;
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';

import '../services/log_delegate/log_delegate.dart';
import 'plugin.dart';

// final serverIsolateSpinnerProvider =
//     Provider.family<ServerIsolateSpinner, String>((ref, arg) {
//   return ServerIsolateSpinner(ref, arg);
// });
final serverIsolateSpinnerProvider = Provider<ServerIsolateSpinner>((ref) {
  return ServerIsolateSpinner(ref);
});

class ServerIsolateSpinner {
  ServerIsolateSpinner(
    this.ref,
    // this.root,
  );
  // final String root;
  final Ref ref;

  String get pluginRoot => p.join(
      Platform.environment['HOME']!,
      '.dartServer',
      'sidecar_analyzer_plugin',
      'my_analyzed_codebase',
      'sidecar_analyzer_plugin_core');

  String get packagesPath => p.join(pluginRoot, 'tools', 'analyzer_plugin',
      '.dart_tool', 'package_config.json');

  String get executablePath =>
      p.join(pluginRoot, 'tools', 'analyzer_plugin', 'bin', 'sidecar.dart');

  LogDelegateBase get delegate => ref.read(logDelegateProvider);

  bool doesAlreadyExist() => Directory(pluginRoot).existsSync();

  late plugin.ServerIsolateChannel channel;

  Future<void> initializeIsolate() async {
    delegate.sidecarMessage('Middleman initialization started...');
    channel = plugin.ServerIsolateChannel.discovered(
      Uri.file(executablePath, windows: Platform.isWindows),
      Uri.file(packagesPath, windows: Platform.isWindows),
      NoopInstrumentationService(),
    );
    await channel.listen(
      ref.read(masterPluginChannelProvider).sendResponse,
      ref.read(masterPluginChannelProvider).sendNotification,
      onDone: () => delegate.sidecarMessage('DONE'),
      onError: (error) => delegate.sidecarMessage('ERROR: ${error.toString()}'),
    );

    delegate.sidecarMessage('Middleman initialization completed.');
  }

  void sendRequest(Request request) {
    channel.sendRequest(request);
  }
}
