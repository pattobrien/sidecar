import 'package:analyzer/file_system/file_system.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';

import '../configurations/rule_package/rule_package_configuration.dart';
import '../protocol/constants/bootstrap_constants.dart';
import '../protocol/constants/constants.dart';
import '../server/server_providers.dart';
import '../utils/file_paths.dart';
import '../utils/logger/logger.dart';
import 'active_project_service.dart';

/// Service for creating entrypoint files for Sidecar Analyzer.
class EntrypointBuilderService {
  /// Service for creating entrypoint files for Sidecar Analyzer.
  const EntrypointBuilderService({
    required ResourceProvider resourceProvider,
  }) : _resourceProvider = resourceProvider;

  final ResourceProvider _resourceProvider;

  void setupPluginSourceFiles(
    Uri packageRoot,
    Uri pluginRoot,
  ) {
    final pluginSourceFolder =
        pluginRoot.resolve(p.join('tools', 'analyzer_plugin', 'bin'));
    final sourceExecutableFolder =
        _resourceProvider.getFolder(pluginSourceFolder.path);

    final pluginFileResources = sourceExecutableFolder.getChildren();

    String _pluginPath(String path, {required Uri newDirectory}) {
      return p.join(
          newDirectory.path, p.relative(path, from: pluginSourceFolder.path));
    }

    pluginFileResources.whereType<File>().forEach((sourceFileEntity) {
      final newDirectory =
          packageRoot.resolve(p.join(kDartTool, kSidecarPluginName));
      final newPath =
          _pluginPath(sourceFileEntity.path, newDirectory: newDirectory);
      final newFile = _resourceProvider.getFile(newPath);
      sourceFileEntity.copyTo(newFile.parent);
    });
  }

  // @visibleForTesting
  void setupBootstrapper(
    Uri packageRoot,
    List<RulePackageConfiguration> lintPackageConfigurations,
  ) {
    final constructorUri = packageRoot
        .resolve(p.join(kDartTool, kSidecarPluginName, 'constructors.dart'));
    final service = ActiveProjectService(resourceProvider: _resourceProvider);
    final config = service.getPackageConfig(packageRoot);
    final sidecarPackages = service.getSidecarDependencies(config);
    logger.finer(
        'setupBootstrapper || adding ${sidecarPackages.length} packages');
    final content = generateEntrypointContent(sidecarPackages);
    final file = _resourceProvider.getFile(constructorUri.path);
    file.writeAsStringSync(content);
  }

  String generateEntrypointContent(
    List<RulePackageConfiguration> sidecarPackageConfigs,
  ) {
    final importsBuffer = StringBuffer()..writeln(constructorFileHeader);
    final listBuffer = StringBuffer()..writeln(constructorListBegin);

    for (final sidecarPackage in sidecarPackageConfigs) {
      final name = sidecarPackage.packageName;
      final package = parseLintPackage(name, sidecarPackage.uri)!;
      importsBuffer.writeln("import 'package:$name/$name.dart' as $name;");
      final rules = [
        ...?package.lints,
        ...?package.assists,
      ];
      for (final rule in rules) {
        listBuffer.writeln('\t$name.${rule.className}.new,');
      }
    }

    final fullContentsBuffer = StringBuffer()
      ..writeln(importsBuffer.toString())
      ..writeln(listBuffer.toString())
      ..writeln(constructorListEnd);

    return fullContentsBuffer.toString();
  }
}

/// Service provider for creating entrypoint files for Sidecar Analyzer.
final isolateBuilderServiceProvider = Provider(
  (ref) {
    final resourceProvider = ref.watch(serverResourceProvider);
    return EntrypointBuilderService(resourceProvider: resourceProvider);
  },
  name: 'isolateBuilderServiceProvider',
  dependencies: [
    serverResourceProvider,
  ],
);
