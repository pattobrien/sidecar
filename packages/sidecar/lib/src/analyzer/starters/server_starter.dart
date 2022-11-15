import 'dart:isolate';

import 'package:analyzer/file_system/file_system.dart';
import 'package:path/path.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../utils/file_paths.dart';

// part 'server_starter.g.dart';

// @riverpod
Future<Isolate> analyzerIsolateStarter({
  required SendPort sendPort,
  required Uri root,
  required ResourceProvider resourceProvider,
  Uri? executable,
  Uri? packageConfig,
  List<String> args = const [],
}) async {
  // to create a plugin, we must do the following:
  // - have an entrypoint uri
  // - have a package_config.json file
  // - start an isolate
  final rootPackageConfig =
      Uri.parse(join(root.path, kDartTool, kPackageConfigJson)).normalizePath();
  final rootExecutable =
      Uri.parse(join(root.path, kDartTool, 'sidecar', 'analyzer.dart'))
          .normalizePath();

  assert(resourceProvider.getFile(rootExecutable.path).exists,
      'executable doesnt exist.');
  assert(resourceProvider.getFile(rootPackageConfig.path).exists,
      'config doesnt exist.');

  final argsWithRoot = <String>[root.path, ...args];

  return Isolate.spawnUri(
    executable ?? rootExecutable,
    argsWithRoot,
    sendPort,
    onError: sendPort,
    onExit: sendPort,
    packageConfig: packageConfig ?? rootPackageConfig,
    debugName: 'sidecar-isolate',
  );
}
