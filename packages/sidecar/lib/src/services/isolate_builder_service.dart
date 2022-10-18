import 'dart:io';

import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:analyzer/instrumentation/noop_service.dart';
// ignore: implementation_imports
import 'package:analyzer_plugin/src/channel/isolate_channel.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';

import '../analyzer/context/context.dart';
import '../protocol/constants/bootstrap_constants.dart';
import '../protocol/constants/constants.dart';
import '../protocol/protocol.dart';
import '../utils/logger/log_delegate_base.dart';

class IsolateBuilderService {
  const IsolateBuilderService(this.ref);
  final Ref ref;

  void _log(String msg) =>
      ref.read(logDelegateProvider).sidecarVerboseMessage(msg);
  IsolateDetails startIsolate(ActiveContext activeContext) {
    _log('STARTING ISOLATE');
    return IsolateDetails(
      channel: _startNewIsolate(activeContext),
      activeRoot: activeContext.activeRoot,
    );
  }

  IsolateDetails updateContext(
      IsolateDetails previousDetails, ActiveContext newContext) {
    return _restartIsolate(previousDetails, activeContext: newContext);
  }

  ServerIsolateChannel _startNewIsolate(ActiveContext activeContext) {
    // create executable file with lints from packages
    _setupPluginSourceFiles(activeContext);
    setupBootstrapper(activeContext);

    // start isolate
    final packagesUri = _packagesUri(activeContext.activeRoot);
    final executableUri = _executableUri(activeContext.activeRoot);

    _log(
        'plugin isolate details: package_config.json=${packagesUri.path} || executable=${executableUri.path}');
    final pluginIsolateChannel = ServerIsolateChannel.discovered(
      executableUri,
      packagesUri,
      NoopInstrumentationService(),
    );

    return pluginIsolateChannel;
  }

  void shutdownIsolate(IsolateDetails details) {
    details.channel.close();
  }

  void _setupPluginSourceFiles(ActiveContext activeContext) {
    // _log(
    //     'getting source files for plugin: ${activeContext.pluginSourceUri.path}');
    final sourceExecutableDirectory = Directory(p.join(
        activeContext.pluginSourceUri.toFilePath(windows: Platform.isWindows),
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
      // _log('copying file.... ${sourceFileEntity.absolute.path}');
      Directory(_pluginPath(
        sourceFileEntity.absolute.parent.path,
        newDirectory: _packageToolDirectory(activeContext.activeRoot),
      )).createSync(recursive: true);
      // _log('created directory: ${directory.path}');
      final newDirectory = _packageToolDirectory(activeContext.activeRoot);
      final newPath = _pluginPath(sourceFileEntity.absolute.path,
          newDirectory: newDirectory);
      // _log('copying file to new path: $newPath in directory #{}');
      sourceFileEntity.copySync(newPath);
    });
    // _log('created: ${pluginFileEntities.length} files');
  }

  IsolateDetails _restartIsolate(
    IsolateDetails previousDetails, {
    required ActiveContext activeContext,
  }) {
    final channel = _startNewIsolate(activeContext);

    shutdownIsolate(previousDetails);
    return IsolateDetails(
        channel: channel, activeRoot: activeContext.activeRoot);
  }

  @visibleForTesting
  void setupBootstrapper(ActiveContext activeContext) {
    final bootstrapperPath = p.join(
        _packageToolDirectory(activeContext.contextRoot).path,
        'constructors.dart');
    final importsBuffer = StringBuffer()..writeln(constructorFileHeader);
    final listBuffer = StringBuffer()..writeln(constructorListBegin);

    final sidecarPackages = activeContext.sidecarPackages;
    _log('_setupBootstrapper || adding ${sidecarPackages.length} packages');

    for (final sidecarPackage in sidecarPackages) {
      final name = sidecarPackage.packageName;
      importsBuffer.writeln("import 'package:$name/$name.dart' as $name;");
      final rules = [
        ...?sidecarPackage.lints,
        ...?sidecarPackage.edits,
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

  Uri _packagesUri(ContextRoot projectRoot) => Uri.file(
      p.join(projectRoot.root.path, '.dart_tool', 'package_config.json'),
      windows: Platform.isWindows);

  Uri _executableUri(ContextRoot projectRoot) => Uri.file(
      p.join(projectRoot.root.path, '.dart_tool', kSidecarPluginName,
          'sidecar.dart'),
      windows: Platform.isWindows);

  Uri _packageToolDirectory(ContextRoot projectRoot) => Uri.directory(
      p.join(projectRoot.root.path, '.dart_tool', kSidecarPluginName),
      windows: Platform.isWindows);
}

final isolateBuilderServiceProvider = Provider(
  (ref) {
    return IsolateBuilderService(ref);
  },
  name: 'isolateBuilderServiceProvider',
  dependencies: [
    logDelegateProvider,
  ],
);

extension ActiveContextX on ActiveContext {
  Uri get pluginSourceUri => sidecarPluginPackage.root;
}
