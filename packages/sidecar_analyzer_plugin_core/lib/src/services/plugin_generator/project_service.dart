import 'dart:io';

import 'package:build_runner_core/build_runner_core.dart';
import 'package:package_config/package_config.dart' as package_config;
import 'package:path/path.dart';
import 'package:pubspec_lock_parse/pubspec_lock_parse.dart' as pubspec_lock;
import 'package:pubspec_parse/pubspec_parse.dart' as pubspec;
import 'package:riverpod/riverpod.dart';
import 'package:path/path.dart' as p;

import '../log_delegate/log_delegate_base.dart';
import 'lint_package_parser.dart';
import 'packages/sidecar_package_config.dart';

final projectServiceProvider =
    Provider.family<ProjectServiceImpl, String>((ref, rootPath) {
  return ProjectServiceImpl(ref, rootPath);
});

class ProjectServiceImpl {
  const ProjectServiceImpl(this.ref, this.rootPath);

  final Ref ref;

  LogDelegateBase get delegate => ref.read(logDelegateProvider);

  bool isValidDartProject() =>
      File(join(rootPath, 'pubspec.yaml')).existsSync();

  Future<Map<String, SidecarPackageConfig>> getSidecarPackages() async {
    final configFile =
        await package_config.findPackageConfig(Directory(rootPath));
    // delegate.sidecarMessage(
    //     'PROJECTSERVICE: configFile is null = ${configFile == null}');
    if (configFile == null) throw UnimplementedError();

    final sidecarPackages = <String, SidecarPackageConfig>{};

    await Future.wait(configFile.packages.map((package) async {
      // delegate.sidecarMessage(
      //     'PROJECTSERVICE: parsing ${package.name} at ${package.root.toFilePath()}...');
      final sidecarPackageConfig = await parseLintPackage(package.root);
      // delegate.sidecarMessage(
      //     'PROJECTSERVICE: ${package.name} is sidecar package = ${sidecarPackageConfig == null}');
      if (sidecarPackageConfig != null) {
        sidecarPackages[package.name] = sidecarPackageConfig;
      }
    }));
    return sidecarPackages;
    // return sidecarPackages;
    // return lockFile.packages.map((key, value) => configFile).values.toSet();
  }

  /// Used to get the sidecar plugin package location from pub cache.
  Future<PackageNode?> getSidecarPluginDependency() async {
    final packageGraph = await PackageGraph.forPath(rootPath);
    return packageGraph.allPackages[kSidecarAnalyzerPlugin];
  }

  final String rootPath;
}

// Set<PackageNode> recursiveSidecarPackageFetch(pubspec_lock.Package node) {
//   final sidecarPackages = <PackageNode>{};
//   // final searchedFile

//   for (final dependency in node.) {
//     if (matchesSidecarPackageSpec(dependency)) {
//       sidecarPackages.add(node);
//     }
//     final recursedPackages = recursiveSidecarPackageFetch(dependency);

//     // if one of dependency's packages contain sidecar, then dependency may contain
//     // lint information as well, therefore it must be added as a dependency
//     if (recursedPackages.isNotEmpty) {
//       sidecarPackages.add(dependency);
//     }
//     sidecarPackages.addAll(recursedPackages);
//   }
//   return sidecarPackages;
// }

bool matchesSidecarPackageSpec(PackageNode node) {
  return node.name == kSidecarAnalyzerPlugin || node.name == 'sidecar';
}

const kSidecarAnalyzerPlugin = 'sidecar_analyzer_plugin_core';
