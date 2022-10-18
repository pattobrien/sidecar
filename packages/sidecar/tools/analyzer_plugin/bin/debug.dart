import 'dart:isolate';
// import 'package:hotreloader/hotreloader.dart';
import 'package:sidecar/sidecar.dart';

import 'constructors.dart';
// import 'package:cli_util/cli_logging.dart';

/// Run lints with the debugger
// Future<void> main(List<String> args, SendPort sendPort) async {
Future<void> main(List<String> args) async {
  final isDebug = args.any((element) => element == '--enable-vm-service');

  // late HotReloader reloader;
  final newArgs = [...args];

  if (isDebug) {
    // print('running in debug mode; HOTRELOAD enabled.');
    //
    // reloader = await HotReloader.create();
    newArgs.add('--debug');
  } else {
    // final s = Ansi(true);
    // print('${s.blue}running in CLI mode. ${s.none}');
  }

  final receivePort = ReceivePort();
  await startSidecarPlugin(
    // sendPort,
    receivePort.sendPort,
    newArgs,
    constructors: constructors,
    isMiddleman: false,
    isPlugin: false,
  );

  // if (isDebug) reloader.stop();
}
