import 'dart:io' as io;

import 'package:path/path.dart' as p;
import 'package:pubspec_parse/pubspec_parse.dart';
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
    final pluginPath =
        p.join(projectDirectory.path, '.sidecar', 'sidecar_analyzer_plugin');
    return io.Directory(pluginPath)..create(recursive: true);
  }

  io.Directory get projectRepositoryDirectory {
    final toolPath = io.Directory(p.join(projectDirectory.path, 'tool'));
    return io.Directory(p.join(toolPath.path, 'sidecar_overrides'));
  }

  Future<void> insertPluginIntoProjectPubspec() async {
    final pubspecFile = io.File(p.join(projectDirectory.path, 'pubspec.yaml'));
    if (pubspecFile.existsSync()) {
      final content = await pubspecFile.readAsString();
      final pubspec = Pubspec.parse(content);

      final hasSidecarDependency =
          pubspec.dependencies.containsKey('sidecar_analyzer_plugin');
      final hasSidecarDevDependency =
          pubspec.devDependencies.containsKey('sidecar_analyzer_plugin');
      final hasSidecarDependencyOverride =
          pubspec.dependencyOverrides.containsKey('sidecar_analyzer_plugin');

      if (hasSidecarDependency) {
        print('sidecar_analyzer_plugin already contained in dependencies');
        return;
      }
      if (hasSidecarDevDependency) {
        print('sidecar_analyzer_plugin already contained in dev dependencies');
        return;
      }
      if (hasSidecarDependencyOverride) {
        print(
            'sidecar_analyzer_plugin already contained in dependency overrides');
        return;
      }
      print('inserting sidecar_analyzer_plugininto project pubspec...');
      final contentWithInsert = pubspec.insertDevDependency(
        content,
        MapEntry(
          'sidecar_analyzer_plugin',
          PathDependency('.sidecar/sidecar_analyzer_plugin/'),
        ),
      );
      await pubspecFile.writeAsString(contentWithInsert);
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
    final packageSourceFiles =
        kPluginMasterRoot.listSync(recursive: true).whereType<io.File>();

    print(
        'copying ${packageSourceFiles.length} plugin source files to project');
    print('copying from relative path: $kPluginMasterRootPath');

    bool hasOverrides = false;
    for (final packageSourceFile in packageSourceFiles) {
      final sourceFileRelativePath =
          p.relative(packageSourceFile.path, from: kPluginMasterRootPath);
      final pluginProjectPath =
          p.join(projectPluginDirectory.path, sourceFileRelativePath);
      final file = await io.File(pluginProjectPath).create(recursive: true);
      if (packageSourceFile.path == kPluginLoaderPath) {
        // replace the plugin loader pubspec file with one that
        // utilizes the newly copied plugin package's path
        hasOverrides = true;
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
    if (hasOverrides == false) {
      final pluginProjectPath =
          p.join(projectPluginDirectory.path, kPluginLoaderPath);
      final file = await io.File(pluginProjectPath).create(recursive: true);
      await file.writeAsString(
          pluginLoaderYamlContentCreator(projectPluginDirectory.path));
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

  Future<void> clearPreviousLints() async {
    final lintProjectCachePath = p.join(
      projectPluginDirectory.path,
      'lib',
      'lints',
    );
    final directory = io.Directory(lintProjectCachePath);
    print('deleting previous lints...');
    final doesDirectoryExist = await directory.exists();
    if (doesDirectoryExist) directory.delete(recursive: true);
  }

  Future<void> importLints(List<LintConfiguration> lints) async {
    for (final lintId in lints) {
      final lintUri = Uri(
          scheme: 'file', path: p.join(cacheDirectory.path, lintId.filePath));

      final lintProjectCacheUri = Uri(
          scheme: 'file',
          path: p.join(
            projectPluginDirectory.path,
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

  Future<void> createProjectRepository() async {
    final projectRepoDirectory = projectRepositoryDirectory;
    // if (projectRepositoryDirectory.existsSync()) {
    //   // directory already exists, so no need to overwrite files
    //   print('project repository already exists');
    //   return;
    // }
    final toolDirectory = io.Directory(p.join(projectDirectory.path, 'tool'));
    await toolDirectory.create(recursive: true);
    print('creating project repository');
    await io.Process.run(
      'dart',
      ['create', '--template=package', 'sidecar_overrides'],
      workingDirectory: toolDirectory.path,
    );
    await io.Process.run(
      'dart',
      ['pub', 'add', '--hosted-url', kCloudsmithSidecarUrl, 'sidecar'],
      workingDirectory: projectRepoDirectory.path,
    );
    await io.Process.run(
      'dart',
      ['pub', 'add', 'analyzer'],
      workingDirectory: projectRepoDirectory.path,
    );
    await io.Process.run(
      'dart',
      ['pub', 'get'],
      workingDirectory: projectRepoDirectory.path,
    );
  }

  Future<void> restartAnalyzerPlugin() async {
    // simplest way to restart plugin is by calling pub get
    // as analyzer_plugin is already designed to restart on pub get
    // final pubspecFile = p.join(projectDirectory.path, 'pubspec.yaml');
    final isFlutterProject =
        await PubspecUtilities.isFlutterProject(projectDirectory.path);
    print(isFlutterProject
        ? 'running flutter pub get...'
        : 'running dart pub get...');
    final result = await io.Process.run(
      isFlutterProject ? 'flutter' : 'dart',
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
