import 'dart:io';

import 'package:build_runner_core/build_runner_core.dart';
import 'package:package_config/package_config.dart' as package_config;
import 'package:path/path.dart';
import 'package:riverpod/riverpod.dart';

import '../log_delegate/log_delegate_base.dart';
import 'lint_package_parser.dart';
import 'packages/sidecar_package_config.dart';

final projectServiceProvider = Provider.family<ProjectServiceImpl, String>(
  (ref, rootPath) {
    return ProjectServiceImpl(ref, rootPath);
  },
  dependencies: [logDelegateProvider],
);

final packageProjectConfigProvider =
    FutureProvider.family<PackageNode?, String>(
  (ref, arg) {
    final projectService = ref.watch(projectServiceProvider(arg));
    return projectService.getSidecarPluginDependency();
  },
  dependencies: [projectServiceProvider],
);

class ProjectServiceImpl {
  const ProjectServiceImpl(this.ref, this.rootPath);

  final Ref ref;

  LogDelegateBase get delegate => ref.read(logDelegateProvider);

  bool isValidDartProject() =>
      File(join(rootPath, 'pubspec.yaml')).existsSync();

  Future<Map<String, SidecarPackageConfig>> getSidecarPackages() async {
    final configFile =
        await package_config.findPackageConfig(Directory(rootPath));

    if (configFile == null) throw UnimplementedError();

    final sidecarPackages = <String, SidecarPackageConfig>{};

    await Future.wait(configFile.packages.map((package) async {
      final sidecarPackageConfig = await parseLintPackage(package.root);
      if (sidecarPackageConfig != null) {
        sidecarPackages[package.name] = sidecarPackageConfig;
      }
    }));
    return sidecarPackages;
  }

  /// Used to get the sidecar plugin package location from pub cache.
  Future<PackageNode?> getSidecarPluginDependency() async {
    final packageGraph = await PackageGraph.forPath(rootPath);
    return packageGraph.allPackages[kSidecarAnalyzerPlugin];
  }

  final String rootPath;
}

const kSidecarAnalyzerPlugin = 'sidecar_analyzer_plugin_core';
