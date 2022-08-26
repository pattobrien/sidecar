import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:sidecar/sidecar.dart';

import 'package:sidecar_cli/sidecar_cli.dart';

final kTempLintCache = p.join(Directory.systemTemp.path, 'pubLintCache');

final kFakeLintRepository = p.join(kAnalyzerLintRepositoryRoot.path);

class SidecarPubServiceImpl extends SidecarPubService {
  @override
  Directory get cacheDirectory =>
      Directory(kFakeLintRepository)..create(recursive: true);

  @override
  Future<void> downloadLintsToCache() {
    // TODO: implement downloadLintsToCache
    throw UnimplementedError();
  }

  @override
  Future<void> downloadLintsToProject(
      List<LintConfiguration> lints, Directory projectDirectory) {
    // TODO: implement downloadLintsToProject
    throw UnimplementedError();
  }
}
