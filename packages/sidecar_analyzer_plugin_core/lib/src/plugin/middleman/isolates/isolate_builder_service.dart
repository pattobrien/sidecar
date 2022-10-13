// ignore_for_file: implementation_imports

import 'dart:io';

import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:analyzer/instrumentation/noop_service.dart';
import 'package:analyzer_plugin/src/channel/isolate_channel.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';

import '../../../bootstrap_constants.dart';
import '../../protocol/protocol.dart';
import 'isolate_details.dart';

class IsolateBuilderService {
  const IsolateBuilderService();

  IsolateDetails startIsolate(
    Uri pluginSourceUri,
    ContextRoot projectRoot,
    List<SidecarPackage> packages,
  ) {
    final channel = _startNewIsolate(pluginSourceUri, projectRoot, packages);

    return IsolateDetails(
      pluginSourceUri: pluginSourceUri,
      channel: channel,
      contextRoot: projectRoot,
      enabledPackages: packages,
    );
  }

  IsolateDetails updateUri(IsolateDetails previousDetails, Uri uri) {
    return _restartIsolate(previousDetails, updatedPluginSourceUri: uri);
  }

  IsolateDetails updatePackages(
      IsolateDetails previousDetails, List<SidecarPackage> packages) {
    return _restartIsolate(previousDetails, updatedPackages: packages);
  }

  IsolateDetails updateContext(
      IsolateDetails previousDetails, ActiveContext context) {
    // return _restartIsolate(previousDetails, updatedPackages: packages);
    throw UnimplementedError();
  }

  ServerIsolateChannel _startNewIsolate(
    Uri pluginSourceUri,
    ContextRoot projectRoot,
    List<SidecarPackage> packages,
  ) {
    // create executable file with lints from packages
    _setupPluginSourceFiles(pluginSourceUri, root: projectRoot);
    _setupBootstrapper(packages, projectRoot);

    // start isolate
    final pluginIsolateChannel = ServerIsolateChannel.discovered(
      _packagesUri(projectRoot),
      _executableUri(projectRoot),
      NoopInstrumentationService(),
    );

    // setup listeners for isolate responses, middleman communication
    //TODO:
    pluginIsolateChannel.listen(
      (response) => throw UnimplementedError('TODO: handle plugin responses'),
      (notification) =>
          throw UnimplementedError('TODO: handle plugin notifications'),
    );

    return pluginIsolateChannel;
  }

  void shutdownIsolate(IsolateDetails details) {
    details.channel.close();
  }

  void _setupPluginSourceFiles(
    Uri pluginSourceUri, {
    required ContextRoot root,
  }) {
    final sourceExecutableDirectory = Directory(
        p.join(pluginSourceUri.path, 'tools', 'analyzer_plugin', 'bin'));

    final pluginFileEntities =
        sourceExecutableDirectory.listSync(recursive: true);

    String _pluginPath(String path, {required Uri newDirectory}) {
      return p.relative(path, from: sourceExecutableDirectory.path);
    }

    pluginFileEntities.whereType<File>().map((sourceFileEntity) {
      Directory(_pluginPath(
        sourceFileEntity.parent.path,
        newDirectory: _packageToolDirectory(root),
      )).createSync();

      sourceFileEntity.copySync(_pluginPath(sourceFileEntity.path,
          newDirectory: _packageToolDirectory(root)));
    });
  }

  IsolateDetails _restartIsolate(
    IsolateDetails previousDetails, {
    List<SidecarPackage>? updatedPackages,
    Uri? updatedPluginSourceUri,
    ContextRoot? updatedContextRoot,
  }) {
    final updatedDetails = previousDetails.copyWith(
      enabledPackages: updatedPackages ?? previousDetails.enabledPackages,
      pluginSourceUri:
          updatedPluginSourceUri ?? previousDetails.pluginSourceUri,
      contextRoot: updatedContextRoot ?? previousDetails.contextRoot,
    );

    final newChannel = _startNewIsolate(
      updatedDetails.pluginSourceUri,
      updatedDetails.contextRoot,
      updatedDetails.enabledPackages,
    );

    shutdownIsolate(previousDetails);
    return updatedDetails.copyWith(channel: newChannel);
  }

  void _setupBootstrapper(Iterable<SidecarPackage> packages, ContextRoot root) {
    final bootstrapperPath =
        p.join(_packageToolDirectory(root).path, 'constructors.dart');
    final importsBuffer = StringBuffer()..writeln(constructorFileHeader);
    final listBuffer = StringBuffer()..writeln(constructorListBegin);

    for (final sidecarPackage in packages) {
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

  Uri _packagesUri(ContextRoot root) =>
      Uri.file(p.join(root.root.path, '.dart_tool', 'package_config.json'),
          windows: Platform.isWindows);

  Uri _executableUri(ContextRoot root) => Uri.file(
      p.join(root.root.path, 'tool', 'sidecar_analyzer_plugin', 'sidecar.dart'),
      windows: Platform.isWindows);

  Uri _packageToolDirectory(ContextRoot root) =>
      Uri.directory(p.join(root.root.path, 'tool', 'sidecar_analyzer_plugin'),
          windows: Platform.isWindows);
}

final isolateBuilderServiceProvider = Provider(
  (ref) {
    return const IsolateBuilderService();
  },
  dependencies: const [],
);
