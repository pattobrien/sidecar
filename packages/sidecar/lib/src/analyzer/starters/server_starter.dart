import 'dart:isolate';

import 'package:analyzer/file_system/file_system.dart';
import 'package:path/path.dart';

import '../../utils/file_paths.dart';

/// Initialize a Sidecar Analyzer isolate from an executable file.
Future<Isolate> analyzerIsolateStarter({
  required SendPort sendPort,
  required Uri root,
  required ResourceProvider resourceProvider,
  Uri? executable,
  Uri? packageConfig,
  List<String> args = const [],
}) async {
  final config = root.resolve(join(kDartTool, kPackageConfigJson));
  final exec = root.resolve(join(kDartTool, 'sidecar', 'analyzer.dart'));

  assert(
      resourceProvider.getFile(exec.path).exists, 'executable doesnt exist.');
  assert(resourceProvider.getFile(config.path).exists, 'config doesnt exist.');

  // add the root path of the package as an arg so that the isolate knows the root
  // uri at startup
  final argsWithRoot = <String>[root.path, ...args];

  return Isolate.spawnUri(
    executable ?? exec,
    argsWithRoot,
    sendPort,
    onError: sendPort,
    onExit: sendPort,
    packageConfig: packageConfig ?? config,
    debugName: 'sidecar-analyzer::${root.pathSegments.reversed.toList()[1]}',
  );
}
