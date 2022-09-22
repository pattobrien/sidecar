import 'dart:convert';
import 'dart:io' as io;

import 'package:path/path.dart' as p;
import 'package:pub_semver/pub_semver.dart';
import 'package:pubspec_parse/pubspec_parse.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';
import 'package:sidecar_cli/src/project/vscode_task.dart';

import 'constants.dart';
import '../utilities/utilities.dart';
import 'file_content_constants.dart';

class ProjectService {
  ProjectService(this.projectDirectory) {
    checkIfPubspecExists();
  }

  Future<void> checkIfPubspecExists() async {
    if (await pubspecFile.exists()) {
      return;
    } else {
      logger.stderr('pubspec file is not in root project dir');
      throw UnimplementedError('pubspec file is not in root project dir');
    }
  }

  final io.Directory projectDirectory;

  io.Directory get projectPluginDirectory {
    final pluginPath =
        p.join(projectDirectory.path, '.sidecar', kSidecarPluginPackageId);
    return io.Directory(pluginPath)..create(recursive: true);
  }

  io.File get pubspecFile =>
      io.File(p.join(projectDirectory.path, 'pubspec.yaml'));

  io.File get sidecarFile =>
      io.File(p.join(projectDirectory.path, 'sidecar.yaml'));

  io.File get analysisOptionsFile =>
      io.File(p.join(projectDirectory.path, 'analysis_options.yaml'));

  io.Directory get projectRepositoryDirectory {
    final toolPath = io.Directory(p.join(projectDirectory.path, 'tool'));
    return io.Directory(p.join(toolPath.path, 'sidecar_overrides'));
  }

  Future<void> setupAnalysisOptionsFile() async {
    final progress = logger.progress(
        '\nchecking for sidecar configuration in ${logger.ansi.emphasized('analysis_options.yaml')} or ${logger.ansi.emphasized('sidecar.yaml')}');

    // if (!(await sidecarFile.exists())) {
    //   await sidecarFile.create(recursive: true);
    //   await sidecarFile.writeAsString(sidecarYamlDefaultContents);
    //   progress.finish(showTiming: true);
    // }
    // progress.finish(showTiming: true);
    if (!analysisOptionsFile.existsSync()) {
      await analysisOptionsFile.create(recursive: true);
      await analysisOptionsFile.writeAsString(analyzerPluginDefaultContents);
      await analysisOptionsFile.writeAsString(sidecarYamlDefaultContents);
      progress.finish(showTiming: true);
    } else {
      //TODO: check if sidecar is setup under analyzer.plugins, and if not add it in
      progress.finish(showTiming: true);
    }
  }

  Future<void> insertProjectPluginIntoPubspec() async {
    final progress = logger.progress(
        '\nadding copied ${logger.ansi.emphasized(kSidecarPluginPackageId)} to project pubspec.yaml');

    try {
      await pubRemovePackages(['sidecar_analyzer_plugin']);
      await pubAddPackages(
        [kSidecarPluginPackageId],
        pathUrl: '.sidecar/sidecar_analyzer_plugin',
        isDevDependency: true,
        workingDirectory: projectDirectory.path,
      );
      progress.finish(showTiming: true);
    } catch (e) {
      logger.stderr('failure while retrieving packages $e');
    }
  }

  Future<void> insertPluginIntoProjectPubspec() async {
    final progress = logger.progress(
        'adding ${logger.ansi.emphasized(kSidecarPluginPackageId)} to project pubspec.yaml file from hosted sidecar server');

    await pubRemovePackages([kSidecarPluginPackageId]);

    await pubAddPackages(
      [kSidecarPluginPackageId],
      hostedUrl: sidecarPluginHostedUrl,
      isDevDependency: true,
    );

    progress.finish(showTiming: true);
  }

  Future<void> pubRemovePackages(
    List<String> packages, {
    String? workingDirectory,
  }) async {
    if (packages.isEmpty) return;

    final isFlutterProject =
        await PubspecUtilities.isFlutterProject(projectDirectory.path);
    final process = await io.Process.start(
      isFlutterProject ? 'flutter' : 'dart',
      [
        'pub',
        'remove',
        ...packages,
      ],
      workingDirectory: workingDirectory ?? projectDirectory.path,
    );
    process.stdout.listen((event) => logger.stdout(utf8.decode(event)));
    process.stderr.listen((event) => logger.stdout(utf8.decode(event)));

    await process.exitCode;
  }

  Future<void> pubAddPackages(
    List<String> packages, {
    bool isDevDependency = false,
    String? hostedUrl,
    String? pathUrl,
    String? workingDirectory,
  }) async {
    assert(pathUrl != null && hostedUrl != null);

    if (packages.isEmpty) return;

    final arguments = ['pub', 'add'];

    if (isDevDependency) arguments.add('--dev');
    if (hostedUrl != null) arguments.addAll(['--hosted-url', hostedUrl]);
    if (pathUrl != null) arguments.addAll(['--path', pathUrl]);

    final isFlutterProject =
        await PubspecUtilities.isFlutterProject(projectDirectory.path);

    final process = await io.Process.start(
      isFlutterProject ? 'flutter' : 'dart',
      [...arguments, ...packages],
      workingDirectory: workingDirectory ?? projectDirectory.path,
    );

    process.stdout.listen((event) => logger.stdout(utf8.decode(event)));
    process.stderr.listen((event) => logger.stdout(utf8.decode(event)));
    await process.exitCode;
  }

  Future<Version> getPluginVersion() async {
    // final pubspecLockFile = io.File(
    //   p.join(projectDirectory.path, 'pubspec.lock'),
    // );
    // final lockFileContents = await pubspecLockFile.readAsString();
    // final lockFile = PubspecLock.parse(lockFileContents);
    // final packageDetails = lockFile.packages['sidecar_analyzer_plugin'];
    // if (packageDetails != null) {
    //   return packageDetails.version;
    // } else {
    //   throw UnimplementedError(
    //     'sidecar_analyzer_plugin should be set as dependency',
    //   );
    // }
    final progress =
        logger.progress('\nfetching appropriate version for this project ');
    final version = Version.parse('0.1.11-dev.17');

    progress.finish(showTiming: true);
    logger.stdout(
        '\nplugin will use ${logger.ansi.emphasized(kSidecarPluginPackageId)} version${logger.ansi.blue} $version ${logger.ansi.none}');
    return version;
  }

  Future<void> copyBasePluginFromSource(Version version) async {
    final progress = logger.progress(
        '\ncopying source code into .sidecar/$kSidecarPluginPackageId directory');
    try {
      // delete any previously copied plugin files
      await projectPluginDirectory.delete(recursive: true);
    } catch (e) {
      // print(e.toString());
    }
    final rootPluginPath = getPluginPackagePathForVersion(version);
    if (!io.Directory(rootPluginPath).existsSync()) {
      // await _downloadSidecarAnalyzerPlugin(version);
    }
    // get all source files from the plugin package
    final packageSourceFiles = io.Directory(rootPluginPath)
        .listSync(recursive: true)
        .whereType<io.File>();

    bool hasOverrides = false;
    for (final packageSourceFile in packageSourceFiles) {
      final sourceFileRelativePath = p.relative(
        packageSourceFile.path,
        from: rootPluginPath,
      );

      final pluginProjectPath =
          p.join(projectPluginDirectory.path, sourceFileRelativePath);

      final file = await io.File(pluginProjectPath).create(recursive: true);
      if (packageSourceFile.path ==
          kPluginLoaderAbsolutePath(pluginProjectPath)) {
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
      final pluginProjectPath = p.join(
        projectPluginDirectory.path,
        kPluginLoaderRelativePath,
      );
      final file = await io.File(pluginProjectPath).create(recursive: true);

      await file.writeAsString(
          pluginLoaderYamlContentCreator(projectPluginDirectory.path));
    }

    progress.finish();
  }

  Future<void> insertVscodeTask() async {
    final progress = logger
        .progress('\ncreating VSCode utilities that watch for sidecar changes');
    final taskFile = io.File(vsCodeTaskPath(projectDirectory.path));
    await taskFile.create(recursive: true);
    await taskFile.writeAsString(vsCodeTaskContent);

    final settingsFile = io.File(vsCodeSettingsPath(projectDirectory.path));
    await settingsFile.create(recursive: true);
    await settingsFile
        .writeAsString(vsCodeSettingsContent(projectDirectory.path));
    progress.finish(showTiming: true);
  }

  Future<void> clearPreviousLints(
    List<LintPackageConfiguration> lints,
    List<EditPackageConfiguration> edits,
  ) async {
    final pluginPubspecFile =
        io.File(p.join(projectPluginDirectory.path, 'pubspec.yaml'));
    final pluginPubspec = Pubspec.parse(await pluginPubspecFile.readAsString());

    final dependenciesToRemove = {
      ...pluginPubspec.dependencies,
      ...pluginPubspec.devDependencies,
    }..removeWhere((key, value) {
        if (value is! HostedDependency) return true;
        if (key == 'sidecar_analyzer_plugin_core') return true;
        if (key == 'sidecar') return true;
        if (key == 'test') return true;
        if (lints.any((lint) => lint.packageName == key)) return true;
        if (edits.any((edit) => edit.packageName == key)) return true;
        return false;
      });

    await pubRemovePackages(dependenciesToRemove.keys.toList(),
        workingDirectory: projectPluginDirectory.path);
  }

  Future<void> importLintsAndEdits(
    List<LintPackageConfiguration> lints,
    List<EditPackageConfiguration> edits,
  ) async {
    final pluginPubspecFile =
        io.File(p.join(projectPluginDirectory.path, 'pubspec.yaml'));

    if (!pluginPubspecFile.existsSync()) {
      throw UnimplementedError('plugin pubspec not found');
    }

    String pubspecContent = await pluginPubspecFile.readAsString();
    final pubspec = Pubspec.parse(pubspecContent); //TODO: set lenient = true
    final packageSet = <String>{}
      ..addAll(lints.map((l) => l.packageName))
      ..addAll(edits.map((e) => e.packageName))
      ..removeWhere((p) => pubspec.dependencies.containsKey(p));

    await pubAddPackages(
      packageSet.toList(),
      hostedUrl: 'https://micropub-3qduh.ondigitalocean.app/',
      workingDirectory: projectPluginDirectory.path,
    );
  }

  Future<void> generateLintBootstrapFunction(
    List<LintPackageConfiguration> lintPackages,
  ) async {
    final importBuffer = StringBuffer()..writeln(pluginImport);
    final returnBuffer = StringBuffer();

    for (final lintPackage in lintPackages) {
      for (final lint in lintPackage.lints.values) {
        importBuffer.write('import \'package:${lint.filePath}\'; \n');
        returnBuffer.write('\t\t${lint.className}.new, \n');
      }

      final entireContents = StringBuffer()
        ..write(importBuffer.toString())
        ..write(lintBootstrapHeader)
        ..write(returnBuffer.toString())
        ..write(bootstrapFooter);

      await io.File(
              p.join(projectPluginDirectory.path, lintInitializerRelativePath))
          .writeAsString(entireContents.toString());
    }
  }

  Future<void> generateCodeEditBootstrapFunction(
    List<EditPackageConfiguration> editPackages,
  ) async {
    final importBuffer = StringBuffer()..writeln(pluginImport);
    final returnBuffer = StringBuffer();

    for (final editPackage in editPackages) {
      for (final edit in editPackage.edits.values) {
        importBuffer.write('import \'package:${edit.filePath}\'; \n');
        returnBuffer.write('\t\t${edit.className}.new,\n');
      }

      final entireContents = StringBuffer()
        ..write(importBuffer.toString())
        ..write(editBootstrapHeader)
        ..write(returnBuffer.toString())
        ..write(bootstrapFooter);

      await io.File(
              p.join(projectPluginDirectory.path, editInitializerRelativePath))
          .writeAsString(entireContents.toString());
    }
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
  (ref, projectDirectory) => ProjectService(projectDirectory),
);
