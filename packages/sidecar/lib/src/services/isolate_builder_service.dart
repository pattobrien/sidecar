import 'dart:io' as io;

import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';

import '../analyzer/server/middleman_resource_provider.dart';
import '../configurations/rule_package/rule_package_configuration.dart';
import '../protocol/active_package.dart';
import '../protocol/constants/bootstrap_constants.dart';
import '../protocol/constants/constants.dart';
import '../protocol/protocol.dart';
import '../utils/file_paths.dart';
import '../utils/logger/logger.dart';
import 'active_project_service.dart';

class IsolateBuilderService {
  const IsolateBuilderService({
    required this.resourceProvider,
  });

  final ResourceProvider resourceProvider;

  void setupPluginSourceFiles(ActivePackage activeContext) {
    final sourceExecutablePath = p.join(
        activeContext.sidecarPluginPackage.root
            .toFilePath(windows: io.Platform.isWindows),
        'tools',
        'analyzer_plugin',
        'bin');
    final sourceExecutableFolder =
        resourceProvider.getFolder(sourceExecutablePath);

    final pluginFileResources = sourceExecutableFolder.getChildren();

    String _pluginPath(String path, {required Uri newDirectory}) {
      return p.join(
          newDirectory.path, p.relative(path, from: sourceExecutablePath));
    }

    pluginFileResources.whereType<File>().forEach((sourceFileEntity) {
      // resourceProvider.getFile(_pluginPath(
      //   sourceFileEntity.parent.path,
      //   newDirectory: _packageToolDirectory(activeContext.packageRoot.root),
      // ));
      final newDirectory =
          _packageToolDirectory(activeContext.packageRoot.root);
      final newPath =
          _pluginPath(sourceFileEntity.path, newDirectory: newDirectory);
      final newFile = resourceProvider.getFile(newPath);
      sourceFileEntity.copyTo(newFile.parent);
    });
  }

  // @visibleForTesting
  void setupBootstrapper(ActivePackage activeContext) {
    final bootstrapperPath = p.join(
        _packageToolDirectory(activeContext.packageRoot.root).path,
        'constructors.dart');
    final importsBuffer = StringBuffer()..writeln(constructorFileHeader);
    final listBuffer = StringBuffer()..writeln(constructorListBegin);
    final root = activeContext.packageRoot.root;
    final sidecarPackages =
        ActiveProjectService(resourceProvider: resourceProvider)
            .getSidecarDependencies(root);
    logger.finer(
        'setupBootstrapper || adding ${sidecarPackages.length} packages');

    for (final sidecarPackage in sidecarPackages) {
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

    final file = resourceProvider.getFile(bootstrapperPath);
    file.writeAsStringSync(fullContentsBuffer.toString());
  }

  Uri _packagesUri(Uri projectRoot) => Uri.file(
        p.join(projectRoot.path, kDartTool, kPackageConfigJson),
      );

  Uri _executableUri(Uri projectRoot) => Uri.file(
        p.join(projectRoot.path, kDartTool, kSidecarPluginName, 'sidecar.dart'),
      );

  Uri _packageToolDirectory(Uri projectRoot) => Uri.directory(
        p.join(projectRoot.path, kDartTool, kSidecarPluginName),
      );
}

final isolateBuilderServiceProvider = Provider(
  (ref) {
    final resourceProvider = ref.watch(middlemanResourceProvider);
    return IsolateBuilderService(resourceProvider: resourceProvider);
  },
  name: 'isolateBuilderServiceProvider',
  dependencies: [
    middlemanResourceProvider,
  ],
);
