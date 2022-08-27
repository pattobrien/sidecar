import 'dart:io' as io;

import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';
import 'package:sidecar_cli/src/project/vscode_task.dart';
import 'package:sidecar_cli/src/sidecar_pub/sidecar_pub_service.dart';

import 'constants.dart';
import '../utilities/utilities.dart';
import 'file_content_constants.dart';

class ProjectService {
  ProjectService(
    this.projectDirectory, {
    required this.cacheDirectory,
  });
  final io.Directory projectDirectory;
  final io.Directory cacheDirectory;

  io.Directory get projectPluginDirectory {
    //TODO: make the plugin directory generation more robust
    //(e.g. what happens when conflicting project names?)
    final projectName = projectDirectory.uri.pathSegments.reversed.toList()[1];
    return getProjectPluginDirectory(projectName);
  }

  Future<void> insertPluginIntoProjectPubspec() async {
    final pubspecFile = io.File(p.join(projectDirectory.path, 'pubspec.yaml'));
    if (pubspecFile.existsSync()) {
      final content = await pubspecFile.readAsString();
      final newContent = '$content \n # ${projectPluginDirectory.path}';
      await pubspecFile.writeAsString(newContent);
    } else {
      throw UnimplementedError('pubspec file is not in root project dir');
    }
  }

  Future<void> copyBasePluginFromSource() async {
    if (projectPluginDirectory.existsSync()) {
      // delete any previously copied plugin files
      await projectPluginDirectory.delete(recursive: true);
    }
    // get all source files from the plugin package
    final packageSourceFiles = kAnalyzerPluginPackageRoot
        .listSync(recursive: true)
        .whereType<io.File>();

    print(
        'copying ${packageSourceFiles.length} plugin source files to project');

    for (final packageSourceFile in packageSourceFiles) {
      final sourceFileRelativePath =
          p.relative(packageSourceFile.path, from: kPluginPackagesRootPath);
      final pluginProjectPath =
          p.join(projectPluginDirectory.path, sourceFileRelativePath);
      final file = await io.File(pluginProjectPath).create(recursive: true);
      if (packageSourceFile.path == kPluginLoaderPath) {
        // replace the plugin loader pubspec file with one that
        // utilizes the newly copied plugin package's path
        await file.writeAsString(
            pluginLoaderYamlContentCreator(projectPluginDirectory.path));
        print('found loader pubspec @ $pluginProjectPath');
      } else {
        // for all files that are not the plugin loader pubspec
        // copy the source files as is
        final contents = await packageSourceFile.readAsBytes();
        await file.writeAsBytes(contents);
      }
    }
  }

  Future<void> insertVscodeTask() async {
    final taskFile = io.File(vsCodeTaskPath(projectDirectory.path));
    await taskFile.create(recursive: true);
    await taskFile.writeAsString(vsCodeTaskContent);

    final settingsFile = io.File(vsCodeSettingsPath(projectDirectory.path));
    await settingsFile.create(recursive: true);
    await settingsFile.writeAsString(vsCodeSettingsContent);
  }

  Future<void> createProjectPluginSymlink() async {
    final linkPath = p.join(projectDirectory.path, '.plugin');
    final pluginPath = projectPluginDirectory.path;
    final link = io.Link(linkPath);
    if (!link.existsSync()) await link.create(pluginPath);
  }

  Future<void> importLints(List<LintConfiguration> lints) async {
    for (final lintId in lints) {
      final lintUri = Uri(
          scheme: 'file', path: p.join(cacheDirectory.path, lintId.filePath));

      final lintProjectCacheUri = Uri(
          scheme: 'file',
          path: p.join(
            projectPluginDirectory.path,
            'sidecar_analyzer_plugin',
            'lib',
            'lints',
            lintId.filePath,
          ));

      try {
        // await dio.downloadUri(lintUri, lintCacheUri.path);
        final file = io.File(lintUri.path); //.create(recursive: true);
        // await file.copy(lintProjectCacheUri.path);
        final contents = await file.readAsBytes();
        final newFile =
            await io.File(lintProjectCacheUri.path).create(recursive: true);
        await newFile.writeAsBytes(contents);
      } catch (e) {
        print('error: $e');
      }
    }
  }

  Future<void> generateLintBootstrapFunction(
      List<LintConfiguration> lints) async {
    final importBuffer = StringBuffer()..writeln(pluginImport);
    final returnBuffer = StringBuffer();

    for (final lint in lints) {
      importBuffer.write('import \'../lints/${lint.filePath}\'; \n');
      returnBuffer
        ..write('\t\t')
        ..write(lint.className)
        ..write('(ref)..registerNodeProcessors(registry), \n');
    }

    final entireContents = StringBuffer()
      ..write(importBuffer.toString())
      ..write(bootstrapHeader)
      ..write(returnBuffer.toString())
      ..write(bootstrapFooter);

    await io.File(
            p.join(projectPluginDirectory.path, lintInitializerRelativePath))
        .writeAsString(entireContents.toString());
  }

  Future<void> restartAnalyzerPlugin() async {
    // simplest way to restart plugin is by calling pub get
    // as analyzer_plugin is already designed to restart on pub get
    // final pubspecFile = p.join(projectDirectory.path, 'pubspec.yaml');

    final result = await io.Process.run(
      'dart',
      ['pub', 'get'],
      workingDirectory: projectDirectory.path,
    );

    print('restartPlugin: ${result.stderr} ${result.stdout}');
  }
}

final projectServiceProvider =
    Provider.family.autoDispose<ProjectService, io.Directory>(
  (ref, projectDirectory) {
    final sidecarPubService = ref.watch(sidecarPubServiceProvider);
    return ProjectService(
      projectDirectory,
      cacheDirectory: sidecarPubService.cacheDirectory,
    );
  },
);
