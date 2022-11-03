import 'dart:io';
import 'dart:isolate';

import 'package:path/path.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../utils/file_paths.dart';

// part 'server_starter.g.dart';

// @riverpod
Future<Isolate> serverSideStarter({
  required SendPort sendPort,
  required Uri root,
  Uri? executable,
  Uri? packageConfig,
  List<String> args = const [],
}) async {
  // to create a plugin, we must do the following:
  // - have an entrypoint uri
  // - have a package_config.json file
  // - start an isolate
  final rootPackageConfig =
      Uri.parse(join(root.path, kDartTool, kPackageConfigJson));
  final rootExecutable =
      Uri.parse(join(root.path, kDartTool, 'sidecar', 'analyzer.dart'));

  assert(File.fromUri(rootExecutable).existsSync(), 'executable doesnt exist.');
  assert(File.fromUri(rootPackageConfig).existsSync(), 'config doesnt exist.');
  return Isolate.spawnUri(
    executable ?? rootExecutable,
    args,
    sendPort,
    onError: sendPort,
    onExit: sendPort,
    packageConfig: packageConfig ?? rootPackageConfig,
    debugName: 'sidecar-isolate',
  );
}
