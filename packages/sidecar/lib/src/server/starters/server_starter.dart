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
  final configPath = join(root.toFilePath(), kDartTool, kPackageConfigJson);
  final execPath =
      join(root.toFilePath(), kDartTool, 'sidecar', kExecutableFile);

  assert(resourceProvider.getFile(execPath).exists, 'executable doesnt exist.');
  assert(resourceProvider.getFile(configPath).exists, 'config doesnt exist.');

  // add the root path of the package as an arg so that the isolate knows the root
  // uri at startup
  final argsWithRoot = <String>[root.toFilePath(), ...args];

  return Isolate.spawnUri(
    Uri.file(execPath),
    argsWithRoot,
    sendPort,
    onError: sendPort,
    onExit: sendPort,
    packageConfig: packageConfig ?? Uri.file(configPath),
    debugName: 'sidecar-analyzer::${root.pathSegments.reversed.toList()[1]}',
  );
}
