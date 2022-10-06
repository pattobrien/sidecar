import 'dart:io';

import 'package:build_runner_core/build_runner_core.dart';
import 'package:package_config/package_config_types.dart';
import 'package:path/path.dart';
import 'package:pubspec_parse/pubspec_parse.dart';
import 'package:riverpod/riverpod.dart';

final projectServiceProvider =
    Provider.family<ProjectServiceImpl, String>((ref, rootPath) {
  return ProjectServiceImpl(rootPath);
});

abstract class ProjectService {
  const ProjectService();
  bool isValidDartProject();
  Future<Set<PackageNode>> getSidecarPackages();
}

class ProjectServiceImpl extends ProjectService {
  const ProjectServiceImpl(this.rootPath);

  @override
  bool isValidDartProject() =>
      File(join(rootPath, 'pubspec.yaml')).existsSync();

  @override
  Future<Set<PackageNode>> getSidecarPackages() async {
    final packageGraph = await PackageGraph.forPath(rootPath);
    return recursiveSidecarPackageFetch(packageGraph.root);
  }

  Future<PackageNode?> getSidecarPluginDependency() async {
    final packageGraph = await PackageGraph.forPath(rootPath);
    final content = await File(rootPath).readAsString();
    final config = PackageConfig.parseString(content, Uri.parse(rootPath));
    config.packages.first.root;
    return packageGraph.allPackages[kSidecarAnalyzerPlugin];
  }

  final String rootPath;
}

Set<PackageNode> recursiveSidecarPackageFetch(PackageNode node) {
  final sidecarPackages = <PackageNode>{};
  // final searchedFile

  for (final dependency in node.dependencies) {
    if (matchesSidecarPackageSpec(dependency)) {
      sidecarPackages.add(node);
    }
    final recursedPackages = recursiveSidecarPackageFetch(dependency);

    // if one of dependency's packages contain sidecar, then dependency may contain
    // lint information as well, therefore it must be added as a dependency
    if (recursedPackages.isNotEmpty) {
      sidecarPackages.add(dependency);
    }
    sidecarPackages.addAll(recursedPackages);
  }
  return sidecarPackages;
}

bool matchesSidecarPackageSpec(PackageNode node) {
  return node.name == kSidecarAnalyzerPlugin || node.name == 'sidecar';
}

const kSidecarAnalyzerPlugin = 'sidecar_analyzer_plugin_core';
