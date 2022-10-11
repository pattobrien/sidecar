import 'dart:isolate';

import 'package:sidecar_analyzer_plugin_core/sidecar_analyzer_plugin_core.dart';

import 'constructors.dart';
import 'is_from_path.dart';

Future<void> main(List<String> args, SendPort sendPort) async {
  // args.add('--instrumentation-log-file=sidecar_logs.txt');

  await startSidecarPlugin(sendPort, args,
      constructors: constructors,
      isMiddleman: true,
      isPlugin: true,
      isInitializedFromPath: isFromPath);
}
