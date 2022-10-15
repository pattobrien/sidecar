import 'dart:isolate';
import 'package:hotreloader/hotreloader.dart';
import 'package:sidecar/sidecar.dart';

import 'constructors.dart';

/// Run lints with the debugger
void main(List<String> args) async {
  final isDebug = args.any((element) => element == '--enable-vm-service');

  late HotReloader reloader;
  final newArgs = [...args];

  if (isDebug) {
    print('running in debug mode; HOTRELOAD enabled.');
    //
    reloader = await HotReloader.create();
    newArgs.add('--debug');
  } else {
    print('running in CLI mode.');
  }

  final receivePort = ReceivePort();
  await startSidecarPlugin(
    receivePort.sendPort,
    newArgs,
    constructors: constructors,
    isMiddleman: false,
    isPlugin: false,
  );

  if (isDebug) reloader.stop();
}
