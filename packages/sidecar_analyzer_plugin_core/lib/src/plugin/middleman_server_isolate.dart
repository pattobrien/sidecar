// ignore_for_file: implementation_imports

import 'dart:async';
import 'dart:io' as io;

import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:analyzer/instrumentation/noop_service.dart';
import 'package:analyzer_plugin/channel/channel.dart';
import 'package:analyzer_plugin/src/channel/isolate_channel.dart' as plugin;
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/builder.dart';

import '../../sidecar_analyzer_plugin_core.dart';
import '../services/log_delegate/log_delegate.dart';
import '../services/plugin_generator/packages/sidecar_package_config.dart';
import '../services/plugin_generator/project_service.dart';
import 'bootstrap_constants.dart';
import 'middleman_communication_router.dart';

final middlemanServerIsolateProvider =
    Provider.family<MiddlemanServerIsolate, ContextRoot>((ref, root) {
  return MiddlemanServerIsolate(ref, root: root);
});

class MiddlemanServerIsolate {
  MiddlemanServerIsolate(this._ref, {required this.root});

  final ContextRoot root;
  final Ref _ref;

  late plugin.ServerIsolateChannel pluginChannel;

  LogDelegateBase get delegate => _ref.read(logDelegateProvider);

  ProjectServiceImpl get projectService =>
      _ref.read(projectServiceProvider(root.root.path));

  MiddlemanCommunicationRouter get middlemanRouter =>
      _ref.read(middlemanCommunicationRouterProvider);
  PluginCommunicationChannel get masterChannel =>
      _ref.read(masterPluginChannelProvider);

  String get packagesPath =>
      p.join(root.root.path, '.dart_tool', 'package_config.json');

  // String get pluginRoot =>
  //     p.join(root.root.path, '.dart_tool', 'sidecar_analyzer_plugin');
  String get pluginRoot =>
      p.join(root.root.path, 'tool', 'sidecar_analyzer_plugin');

  String get pluginExecutablePath => p.join(pluginRoot, 'sidecar.dart');

  bool doesAlreadyExist() => io.Directory(pluginRoot).existsSync();

  bool isRootValidProject() {
    delegate.sidecarMessage('PROJECTSERVICE: root path ${root.root.path}');
    final isValidProject = projectService.isValidDartProject();
    delegate.sidecarMessage('PROJECTSERVICE: is valid $isValidProject');
    return isValidProject;
  }

  Future<void> setupPluginSourceFiles() async {
    final sidecarDep = await projectService.getSidecarPluginDependency();

    if (sidecarDep == null) {
      throw UnimplementedError('getSidecarPluginDependency returned null');
    }

    final pluginToolPath =
        p.join(sidecarDep.path, 'tools', 'analyzer_plugin', 'bin');

    final directory = io.Directory(p.join(pluginToolPath));
    await directory.create(recursive: true);

    final pluginFileEntities = directory.listSync(recursive: true);

    String relativePluginFilePath(String path) {
      return p.relative(path, from: pluginToolPath);
    }

    await Future.wait(
        pluginFileEntities.whereType<io.Directory>().map((e) async {
      final newPath = p.join(pluginRoot, relativePluginFilePath(e.path));
      await io.Directory(newPath).create(recursive: true);
    }));

    await Future.wait(pluginFileEntities.whereType<io.File>().map((e) async {
      final newPath = p.join(pluginRoot, relativePluginFilePath(e.path));

      await e.copy(newPath);
    }));

    await setupBootstrapper();
  }

  Future<void> setupBootstrapper() async {
    // delegate.sidecarMessage('MIDDLEMAN: setting up bootstrapper');
    final bootstrapperPath = p.join(pluginRoot, 'constructors.dart');
    final importsBuffer = StringBuffer()..writeln(constructorFileHeader);
    final listBuffer = StringBuffer()..writeln(constructorListBegin);
    // delegate.sidecarMessage('MIDDLEMAN: getSidecarPackages init');
    final sidecarPackages = await projectService.getSidecarPackages();
    // delegate.sidecarMessage(
    //     'MIDDLEMAN: getSidecarPackages completed: ${sidecarPackages.entries.length} packages');
    for (final sidecarPackage in sidecarPackages.entries) {
      final packageName = sidecarPackage.key;
      final importStatement =
          "import 'package:$packageName/$packageName.dart' as $packageName;";
      importsBuffer.writeln(importStatement);
      for (final rule in sidecarPackage.value.lints ?? <LintNode>[]) {
        final constructorStatement = '\t$packageName.${rule.className}.new,';
        listBuffer.writeln(constructorStatement);
      }
      for (final rule in sidecarPackage.value.edits ?? <EditNode>[]) {
        final constructorStatement = '\t$packageName.${rule.className}.new,';
        listBuffer.writeln(constructorStatement);
      }
      final numberOfConstructors = (sidecarPackage.value.lints?.length ?? 0) +
          (sidecarPackage.value.edits?.length ?? 0);
      delegate.sidecarMessage(
          'MIDDLEMAN: concatenated $numberOfConstructors constructors');
    }
    importsBuffer.writeln();
    listBuffer.write(constructorListEnd);
    final contents = importsBuffer.toString() + listBuffer.toString();
    await io.File(bootstrapperPath).writeAsString(contents);
  }

  Future<void> initializeIsolate() async {
    delegate.sidecarMessage('Isolate initialization started...');

    pluginChannel = plugin.ServerIsolateChannel.discovered(
      Uri.file(pluginExecutablePath, windows: io.Platform.isWindows),
      Uri.file(packagesPath, windows: io.Platform.isWindows),
      NoopInstrumentationService(),
    );

    delegate.sidecarMessage(
        'Isolate initialization completed; setting up listeners...');
    await pluginChannel.listen(
      (response) => middlemanRouter.handlePluginResponse(root, response),
      (notif) => middlemanRouter.handlePluginNotification(root, notif),
      onDone: () => middlemanRouter.handlePluginDone(root),
      onError: (error) {
        delegate.sidecarMessage('ISOLATE ERROR: ${error.toString()}');
        middlemanRouter.handlePluginError(root, error);
      },
    );
    // TODO: remove this
    // await Future.delayed(Duration(seconds: 4)); // give isolate time to load

    delegate.sidecarMessage('DONE: Isolate initialization completed.');
  }
}
