// ignore_for_file: implementation_imports

import 'dart:async';
import 'dart:io' as io;

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer/instrumentation/noop_service.dart';
import 'package:analyzer_plugin/channel/channel.dart' as plugin;
import 'package:analyzer_plugin/plugin/plugin.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_constants.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:analyzer_plugin/src/channel/isolate_channel.dart' as plugin;
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';
import 'package:pubspec_lock_parse/pubspec_lock_parse.dart' as pubspec_lock;

import '../../sidecar_analyzer_plugin_core.dart';
import '../constants.dart';
import '../context_services/context_services.dart';
import '../services/log_delegate/log_delegate.dart';
import '../services/plugin_generator/project_service.dart';
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

  String get packagesPath =>
      p.join(root.root.path, '.dart_tool', 'package_config.json');

  String get pluginRoot =>
      p.join(root.root.path, '.dart_tool', 'sidecar_analyzer_plugin');

  String get pluginExecutablePath => p.join(pluginRoot, 'bin', 'sidecar.dart');

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

    final pluginToolPath = p.join(sidecarDep.path, 'tools', 'analyzer_plugin');

    final pluginFileEntities =
        io.Directory(p.join(pluginToolPath)).listSync(recursive: true);

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
  }

  Future<void> createBootstrapFile() async {
    // final deps = await projectService.getSidecarPackages();
    // delegate.sidecarMessage('PROJECTSERVICE: ${deps.length} sidecar deps');

    // for (final dep in deps.entries) {
    //   delegate.sidecarMessage('PROJECTSERVICE: dependency: ${dep.key}');
    // }
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
      (request) => middlemanRouter.handlePluginResponse(root, request),
      (notif) => middlemanRouter.handlePluginNotification(root, notif),
      onDone: () => middlemanRouter.handlePluginDone(root),
      onError: (error) => middlemanRouter.handlePluginError(root, error),
    );

    delegate.sidecarMessage('Middleman initialization completed.');
  }
}
