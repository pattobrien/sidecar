// ignore_for_file: implementation_imports

import 'dart:async';
import 'dart:io' as io;

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer/instrumentation/noop_service.dart';
import 'package:analyzer_plugin/channel/channel.dart' as plugin;
import 'package:analyzer_plugin/plugin/plugin.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_constants.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:analyzer_plugin/src/channel/isolate_channel.dart' as plugin;
import 'package:build_runner_core/build_runner_core.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';

import '../../sidecar_analyzer_plugin_core.dart';
import '../constants.dart';
import '../context_services/context_services.dart';
import '../services/log_delegate/log_delegate.dart';
import '../services/plugin_generator/project_service.dart';

final middlemanPluginProvider = Provider((ref) {
  return MiddlemanPlugin(ref);
});

class MiddlemanPlugin extends plugin.ServerPlugin {
  MiddlemanPlugin(
    this._ref, {
    ResourceProvider? resourceProvider,
  }) : super(
          resourceProvider:
              resourceProvider ?? PhysicalResourceProvider.INSTANCE,
        );

  HotReloader? _reloader;
  final initializationCompleter = Completer<void>();
  final Ref _ref;

  @override
  String get name => pluginName;

  @override
  String get version => pluginVersion;

  @override
  List<String> get fileGlobsToAnalyze => pluginGlobs;

  SidecarAnalyzerMode get mode => _ref.read(sidecarAnalyzerMode);
  LogDelegateBase get delegate => _ref.read(logDelegateProvider);

  AnalysisContextService getAnalysisContextService(AnalysisContext context) =>
      _ref.read(analysisContextServiceProvider(context));

  @override
  void start(plugin.PluginCommunicationChannel channel) {
    delegate.sidecarMessage('MIDDLEMAN STARTING....');
    _start(channel);
  }

  Future<void> _start(
    plugin.PluginCommunicationChannel channel,
  ) async {
    if (mode.isDebug) await _startWithHotReload(channel);
    await initializeIsolate();
    _ref.read(masterPluginChannelProvider).listen(sendRequest);
  }

  late plugin.ServerIsolateChannel pluginChannel;

  String get pluginRoot => p.join(
      io.Platform.environment['HOME']!,
      '.dartServer',
      'sidecar_analyzer_plugin',
      'my_analyzed_codebase',
      'sidecar_analyzer_plugin_core');

  String get packagesPath => p.join(pluginRoot, 'tools', 'analyzer_plugin',
      '.dart_tool', 'package_config.json');

  String get executablePath =>
      p.join(pluginRoot, 'tools', 'analyzer_plugin', 'bin', 'sidecar.dart');

  bool doesAlreadyExist() => io.Directory(pluginRoot).existsSync();

  Future<void> initializeIsolate() async {
    delegate.sidecarMessage('Middleman initialization started...');
    pluginChannel = plugin.ServerIsolateChannel.discovered(
      Uri.file(executablePath, windows: io.Platform.isWindows),
      Uri.file(packagesPath, windows: io.Platform.isWindows),
      NoopInstrumentationService(),
    );
    await pluginChannel.listen(
      _ref.read(masterPluginChannelProvider).sendResponse,
      _ref.read(masterPluginChannelProvider).sendNotification,
      onDone: () => delegate.sidecarMessage('DONE'),
      onError: (error) => delegate.sidecarMessage('ERROR: ${error.toString()}'),
    );

    delegate.sidecarMessage('Middleman initialization completed.');
  }

  void sendRequest(plugin.Request request) {
    if (request.method == plugin.ANALYSIS_REQUEST_SET_CONTEXT_ROOTS) {
      _handleContextRequest(request);
    }
    pluginChannel.sendRequest(request);
  }

  Future<void> _handleContextRequest(plugin.Request request) async {
    final params = plugin.AnalysisSetContextRootsParams.fromRequest(request);
    await Future.wait(params.roots.map((root) async {
      final projectService = _ref.read(projectServiceProvider(root.root));

      delegate.sidecarMessage('PROJECTSERVICE: root path ${root.root}');
      final isValidProject = projectService.isValidDartProject();
      delegate.sidecarMessage('PROJECTSERVICE: is valid $isValidProject');
      if (!isValidProject) return;

      final deps = await projectService.getSidecarPackages();
      delegate.sidecarMessage('PROJECTSERVICE: ${deps.length} sidecar deps');
      for (final dep in deps) {
        delegate.sidecarMessage('PROJECTSERVICE: dependency: ${dep.name}');
      }
      final sidecarDep = await projectService.getSidecarPluginDependency();
      if (sidecarDep == null) throw UnimplementedError();

      final pluginToolPath =
          p.join(sidecarDep.path, 'tools', 'analyzer_plugin');

      final pluginFileEntities =
          io.Directory(p.join(pluginToolPath)).listSync(recursive: true);

      String getPluginRelativePath(String path) {
        return p.relative(path, from: pluginToolPath);
      }

      await Future.wait(
          pluginFileEntities.whereType<io.Directory>().map((e) async {
        final newPath = p.join(root.root, '.sidecar', 'sidecar_plugin',
            getPluginRelativePath(e.path));
        await io.Directory(newPath).create(recursive: true);
      }));

      await Future.wait(pluginFileEntities.whereType<io.File>().map((e) async {
        final newPath = p.join(root.root, '.sidecar', 'sidecar_plugin',
            getPluginRelativePath(e.path));
        await e.copy(newPath);
      }));

      await _generatePubspec(deps, root.root);
    }));
  }

  Future<void> _generatePubspec(Set<PackageNode> nodes, String path) async {
    final directory = io.Directory(p.join(path, '.sidecar', 'sidecar_plugin'));
    await directory.create(recursive: true);
    final file = io.File(p.join(directory.path, 'pubspec.yaml'));
    final buffer = StringBuffer();
    buffer.writeln('name: sidecar_gen');
    buffer.writeln();
    buffer.writeln('environment:');
    buffer.writeln('  sdk: ">=2.17.5 <3.0.0"');
    buffer.writeln();
    buffer.writeln('dependencies:');
    for (final node in nodes) {
      buffer.writeln('  ${node.name}:');
      buffer.writeln('    path: ${node.path}');
    }
    await file.writeAsString(buffer.toString());
    delegate.sidecarMessage('PROJECTSERVICE: done generating pubspec');
  }

  Future<void> _startWithHotReload(
    plugin.PluginCommunicationChannel channel,
  ) async {
    _reloader = await HotReloader.create(onAfterReload: (c) {
      if (c.result == HotReloadResult.Succeeded) {
        _ref
            .read(masterPluginChannelProvider)
            .sendNotification(plugin.Notification('sidecar.auto_reload', {}));
      }
    });
  }

  Future<void> reload() async {
    await _reloader?.reloadCode();
  }

  @override
  Future<void> analyzeFile({
    required AnalysisContext analysisContext,
    required String path,
  }) async {}
}
