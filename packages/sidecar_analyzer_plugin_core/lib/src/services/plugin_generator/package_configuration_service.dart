import 'dart:async';
import 'dart:io';

import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:build_runner_core/build_runner_core.dart';
import 'package:package_config/package_config.dart';
import 'package:path/path.dart';
import 'package:riverpod/riverpod.dart';

import '../../constants.dart';
import '../log_delegate/log_delegate_base.dart';
import 'lint_package_parser.dart';
import 'packages/sidecar_package_config.dart';

final packageConfigurationProvider =
    FutureProvider.family<PackageConfig, ContextRoot>(
  (ref, root) async {
    final service = ref.watch(packageConfigServiceProvider(root.root.toUri()));
    return service.initialize();
  },
  dependencies: [packageConfigServiceProvider],
);

final packageConfigServiceProvider =
    Provider.family<PackageConfigurationService, Uri>(
  PackageConfigurationService.new,
  dependencies: [logDelegateProvider],
);

class PackageConfigurationService {
  const PackageConfigurationService(this.ref, this.rootUri);

  final Ref ref;
  final Uri rootUri;

  LogDelegateBase get delegate => ref.read(logDelegateProvider);

  bool isValidDartProject() =>
      File(join(rootUri.toFilePath(), 'pubspec.yaml')).existsSync();

  Future<PackageConfig> initialize() async {
    final path =
        join(rootUri.toFilePath(), '.dart_tool', 'package_config.json');
    final contents = await File(path).readAsBytes();
    return PackageConfig.parseBytes(contents, rootUri);
  }

  Future<Map<String, SidecarPackageConfig>> findAllSidecarDeps(
    PackageConfig config,
  ) async {
    final sidecarPackages = <String, SidecarPackageConfig>{};
    delegate.sidecarMessage(
        'findAllSidecarDeps for ${rootUri.toFilePath()} // ${rootUri.path}');
    await Future.wait(config.packages.map((package) async {
      try {
        delegate.sidecarMessage(
            'findAllSidecarDeps for name ${package.name} @ path ${package.root.toFilePath(windows: Platform.isWindows)} // ${package.root.normalizePath().path}');
        final sidecarPackageConfig = await parseLintPackage(package.root);
        if (sidecarPackageConfig != null) {
          sidecarPackages[package.name] = sidecarPackageConfig;
        }
      } catch (e, stackTrace) {
        delegate.sidecarError('NON-FATAL ERROR: $e', stackTrace);
      }
    }));
    return sidecarPackages;
  }

  /// Used to get the sidecar plugin package location from pub cache.
  Future<PackageNode?> getSidecarPluginDependency() async {
    final packageGraph = await PackageGraph.forPath(rootUri.path);
    return packageGraph.allPackages[kSidecarPluginName];
  }
}
