import 'dart:io';

import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';

abstract class SidecarPubService {
  Directory get cacheDirectory;
  Future<void> downloadLintsToCache();
  Future<void> downloadLintsToProject(
      List<LintConfiguration> lints, Directory projectDirectory);
}

final sidecarPubServiceProvider =
    Provider<SidecarPubService>((ref) => throw UnimplementedError());
