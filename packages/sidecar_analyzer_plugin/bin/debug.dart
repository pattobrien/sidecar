import 'dart:isolate';

import 'package:sidecar_analyzer_plugin/src/analyzer_plugin_starter.dart';
import 'package:sidecar_analyzer_plugin_core/sidecar_analyzer_plugin_core.dart';

/// Run lints with the debugger
void main(List<String> args) async {
  final isDebug = args.any((element) => element == '--enable-vm-service');

  late HotReloader reloader;
  final newArgs = [...args];

  if (isDebug) {
    print('running in debug mode; HOTRELOAD enabled.');
    reloader = await HotReloader.create();
    newArgs.add('--debug');
  } else {
    print('running in CLI mode.');
  }

  final receivePort = ReceivePort();
  await start(newArgs, receivePort.sendPort, false);

  if (isDebug) reloader.stop();
}
