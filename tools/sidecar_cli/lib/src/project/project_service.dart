import 'dart:convert';
import 'dart:io' as io;

import 'package:cli_util/cli_logging.dart';
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
  const ProjectService(this.projectDirectory);

  final io.Directory projectDirectory;

  io.Directory get projectPluginDirectory {
    final pluginPath = p.join(
      projectDirectory.path,
      '.sidecar',
      'sidecar_analyzer_plugin',
    );
    return io.Directory(pluginPath)..create(recursive: true);
  }

  io.Directory get projectRepositoryDirectory {
    final toolPath = io.Directory(p.join(projectDirectory.path, 'tool'));
    return io.Directory(p.join(toolPath.path, 'sidecar_overrides'));
  }

  Future<void> setupAnalysisOptionsFile() async {
    final progress = logger.progress(
        '\nchecking for sidecar configuration in ${logger.ansi.emphasized('analysis_options.yaml')} or ${logger.ansi.emphasized('sidecar.yaml')}');
    final analysisOptionsFile =
        io.File(p.join(projectDirectory.path, 'analysis_options.yaml'));
    if (!analysisOptionsFile.existsSync()) {
      progress.finish(showTiming: true);
      await analysisOptionsFile.writeAsString(analysisDefaultContents);
    } else {
      //TODO: check if sidecar is setup under analyzer.plugins, and if not add it in
      progress.finish(showTiming: true);
    }
  }

  Future<void> insertProjectPluginIntoPubspec() async {
    final progress = logger.progress(
        '\nadding copied ${logger.ansi.emphasized('sidecar_analyzer_plugin')} to project pubspec.yaml');
    final pubspecFile = io.File(p.join(projectDirectory.path, 'pubspec.yaml'));
    if (pubspecFile.existsSync()) {
      try {
        final isFlutterProject =
            await PubspecUtilities.isFlutterProject(projectDirectory.path);

        final process = await io.Process.start(
          isFlutterProject ? 'flutter' : 'dart',
          [
            'pub',
            'add',
            '--dev',
            '--path',
            '.sidecar/sidecar_analyzer_plugin/',
            'sidecar_analyzer_plugin',
          ],
          workingDirectory: projectDirectory.path,
        );
        process.stdout.listen((event) => logger.trace(utf8.decode(event)));
        process.stderr.listen((event) => logger.trace(utf8.decode(event)));
        await process.exitCode;
        progress.finish(showTiming: true);
      } catch (e) {
        logger.stderr('failure while retrieving ');
      }
    } else {
      throw UnimplementedError('pubspec file is not in root project dir');
    }
  }

  Future<void> insertPluginIntoProjectPubspec() async {
    final pubspecFile = io.File(p.join(projectDirectory.path, 'pubspec.yaml'));
    if (pubspecFile.existsSync()) {
      final progress = logger.progress(
          'adding ${logger.ansi.emphasized('sidecar_analyzer_plugin')} to project pubspec.yaml file from hosted sidecar server');
      final isFlutterProject =
          await PubspecUtilities.isFlutterProject(projectDirectory.path);

      final process = await io.Process.start(
        isFlutterProject ? 'flutter' : 'dart',
        [
          'pub',
          'remove',
          'sidecar_analyzer_plugin',
        ],
        workingDirectory: projectDirectory.path,
      );
      process.stdout.listen((event) => logger.trace(utf8.decode(event)));
      process.stderr.listen((event) => logger.trace(utf8.decode(event)));

      await process.exitCode;

      final addProcess = await io.Process.start(
        isFlutterProject ? 'flutter' : 'dart',
        [
          'pub',
          'add',
          '--dev',
          '--hosted-url',
          'https://dart.cloudsmith.io/fine-designs/sidecar_analyzer_plugin/',
          'sidecar_analyzer_plugin',
        ],
        workingDirectory: projectDirectory.path,
      );
      addProcess.stdout.listen((event) => logger.trace(utf8.decode(event)));
      addProcess.stderr.listen((event) => logger.trace(utf8.decode(event)));
      progress.finish(showTiming: true);
    } else {
      // throw UnimplementedError('pubspec file is not in root project dir');
      logger.stderr('\npubspec file is not in current directory!');
    }
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
    final version = Version.parse('0.1.10');

    progress.finish(showTiming: true);
    logger.stdout(
        '\nplugin will use ${logger.ansi.emphasized('sidecar_analyzer_plugin')} version${logger.ansi.blue} $version ${logger.ansi.none}');
    return version;
  }

  // Future<void> _downloadSidecarAnalyzerPlugin(Version version) async {
  //   final process = await io.Process.start(
  //     'dart',
  //     [
  //       'pub',
  //       'add',
  //       '--dev',
  //       '--hosted-url',
  //       'https://dart.cloudsmith.io/fine-designs/sidecar_analyzer_plugin/',
  //       'sidecar_analyzer_plugin',
  //     ],
  //     workingDirectory: projectDirectory.path,
  //   );
  //   process.stdout.listen((event) => print(utf8.decode(event)));
  //   process.stderr.listen((event) => print(utf8.decode(event)));
  //   await process.exitCode;
  // }

  Future<void> copyBasePluginFromSource(Version version) async {
    final progress = logger.progress(
        '\ncopying source code into .sidecar/sidecar_analyzer_plugin directory');
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

    // print(
    //     'copying ${packageSourceFiles.length} plugin source files to project');
    // print(
    //     'copying from relative path: ${getPluginPackagePathForVersion(pluginVersion)}');

    bool hasOverrides = false;
    for (final packageSourceFile in packageSourceFiles) {
      final sourceFileRelativePath = p.relative(
        packageSourceFile.path,
        from: rootPluginPath,
      );

      // print('relative source path: $sourceFileRelativePath');

      final pluginProjectPath =
          p.join(projectPluginDirectory.path, sourceFileRelativePath);

      // print('copied source path: $pluginProjectPath');

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

  Future<void> createProjectPluginSymlink() async {
    final linkPath = p.join(projectDirectory.path, '.plugin');
    final pluginPath = projectPluginDirectory.path;
    final link = io.Link(linkPath);
    if (!link.existsSync()) await link.create(pluginPath);
  }

  Future<void> clearPreviousLints(
    List<LintPackageConfiguration> lints,
    List<EditPackageConfiguration> edits,
  ) async {
    final pubspecFile =
        io.File(p.join(projectPluginDirectory.path, 'pubspec.yaml'));
    final pubspec = Pubspec.parse(await pubspecFile.readAsString());

    final dependenciesToRemove = {
      ...pubspec.dependencies,
      ...pubspec.devDependencies,
    }..removeWhere((key, value) {
        if (value is! HostedDependency) return true;
        if (key == 'sidecar_analyzer_plugin_core') return true;
        if (key == 'sidecar') return true;
        if (lints.any((lint) => lint.packageName == key)) return true;
        if (edits.any((edit) => edit.packageName == key)) return true;
        return false;
      });

    await Future.wait<void>(dependenciesToRemove.entries.map((dep) async {
      final process = await io.Process.start(
        'dart',
        ['pub', 'remove', dep.key],
        workingDirectory: projectPluginDirectory.path,
      );
      process.stdout.listen((event) => print(utf8.decode(event)));
      process.stderr.listen((event) => print(utf8.decode(event)));
      await process.exitCode;
    }));
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

    if (packageSet.isNotEmpty) {
      final lintArguments = <String>['pub', 'add'];

      for (final package in packageSet) {
        lintArguments.add(package);
      }

      lintArguments.add('--hosted-url');
      lintArguments.add('https://micropub-3qduh.ondigitalocean.app/');

      final isFlutterProject =
          await PubspecUtilities.isFlutterProject(projectDirectory.path);

      final process = await io.Process.start(
        isFlutterProject ? 'flutter' : 'dart',
        lintArguments,
        workingDirectory: pluginPubspecFile.parent.path,
      );

      process.stdout.listen((event) => print(utf8.decode(event)));
      process.stderr.listen((event) => print(utf8.decode(event)));
      await process.exitCode;
    }
  }

  // Future<void> importEdits(List<EditPackageConfiguration> editPackages) async {
  //   final pluginPubspecFile =
  //       io.File(p.join(projectPluginDirectory.path, 'pubspec.yaml'));

  //   if (!pluginPubspecFile.existsSync()) {
  //     throw UnimplementedError('plugin pubspec not found');
  //   }

  //   String pubspecContent = await pluginPubspecFile.readAsString();
  //   final pubspec = Pubspec.parse(pubspecContent);
  //   await Future.wait(editPackages.map((editConfiguration) async {
  //     if (!pubspec.dependencies.containsKey(editConfiguration.packageName)) {
  //       final isFlutterProject =
  //           await PubspecUtilities.isFlutterProject(projectDirectory.path);
  //       final process = await io.Process.start(
  //         isFlutterProject ? 'flutter' : 'dart',
  //         [
  //           'pub',
  //           'add',
  //           '--hosted-url',
  //           'https://micropub-3qduh.ondigitalocean.app/',
  //           editConfiguration.packageName,
  //         ],
  //         workingDirectory: pluginPubspecFile.parent.path,
  //       );

  //       process.stdout.listen((event) => print(utf8.decode(event)));
  //       process.stderr.listen((event) => print(utf8.decode(event)));
  //       await process.exitCode;
  //     }
  //   }));
  // }

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
  (ref, projectDirectory) {
    // final sidecarPubService = ref.watch(sidecarPubServiceProvider);
    return ProjectService(
      projectDirectory,
      // cacheDirectory: sidecarPubService.cacheDirectory,
    );
  },
);
