import 'dart:io';

import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';

import '../configurations/rule_package/rule_package_configuration.dart';
import '../protocol/active_package.dart';
import '../protocol/constants/bootstrap_constants.dart';
import '../protocol/constants/constants.dart';
import '../protocol/protocol.dart';
import '../utils/file_paths.dart';
import '../utils/logger/logger.dart';
import 'active_project_service.dart';

class IsolateBuilderService {
  const IsolateBuilderService();

  void setupPluginSourceFiles(ActivePackage activeContext) {
    final sourceExecutableDirectory = Directory(p.join(
        activeContext.sidecarPluginPackage.root
            .toFilePath(windows: Platform.isWindows),
        'tools',
        'analyzer_plugin',
        'bin'));

    final pluginFileEntities =
        sourceExecutableDirectory.listSync(recursive: true);

    String _pluginPath(String path, {required Uri newDirectory}) {
      return p.join(newDirectory.path,
          p.relative(path, from: sourceExecutableDirectory.path));
    }

    pluginFileEntities.whereType<File>().forEach((sourceFileEntity) {
      Directory(_pluginPath(
        sourceFileEntity.absolute.parent.path,
        newDirectory: _packageToolDirectory(activeContext.packageRoot.root),
      )).createSync(recursive: true);
      final newDirectory =
          _packageToolDirectory(activeContext.packageRoot.root);
      final newPath = _pluginPath(sourceFileEntity.absolute.path,
          newDirectory: newDirectory);

      sourceFileEntity.copySync(newPath);
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
    final resourceProvider = PhysicalResourceProvider.INSTANCE;
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

    final fullContents = StringBuffer()
      ..writeln(importsBuffer.toString())
      ..writeln(listBuffer.toString())
      ..writeln(constructorListEnd);

    File(bootstrapperPath).writeAsStringSync(fullContents.toString());
  }

  Uri _packagesUri(Uri projectRoot) =>
      Uri.file(p.join(projectRoot.path, kDartTool, kPackageConfigJson),
          windows: Platform.isWindows);

  Uri _executableUri(Uri projectRoot) => Uri.file(
      p.join(projectRoot.path, kDartTool, kSidecarPluginName, 'sidecar.dart'),
      windows: Platform.isWindows);

  Uri _packageToolDirectory(Uri projectRoot) =>
      Uri.directory(p.join(projectRoot.path, kDartTool, kSidecarPluginName),
          windows: Platform.isWindows);
}

final isolateBuilderServiceProvider = Provider(
  (ref) => const IsolateBuilderService(),
  name: 'isolateBuilderServiceProvider',
  dependencies: const [],
);
