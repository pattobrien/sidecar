// ignore_for_file: implementation_imports

import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/src/workspace/workspace.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:meta/meta.dart';

import 'analyzed_file.dart';

@immutable
class ActiveContextRoot {
  const ActiveContextRoot(
    this._root, {
    required this.isMainRoot,
  });

  final ContextRoot _root;

  /// Indicates the package that explicitly activates Sidecar as a plugin.
  final bool isMainRoot;

  List<AnalyzedFile> typedAnalyzedFiles() =>
      analyzedFiles().map((e) => AnalyzedFile(this, e)).toList();

  plugin.ContextRoot get toPluginContextRoot =>
      plugin.ContextRoot(_root.root.path, []);

  Iterable<String> analyzedFiles() => _root.analyzedFiles();

  List<Resource> get excluded => _root.excluded;

  Iterable<String> get excludedPaths => _root.excludedPaths;

  List<Resource> get included => _root.included;

  Iterable<String> get includedPaths => _root.includedPaths;

  bool isAnalyzed(String path) => _root.isAnalyzed(path);

  File? get optionsFile => _root.optionsFile;

  File? get packagesFile => _root.packagesFile;

  ResourceProvider get resourceProvider => _root.resourceProvider;

  Folder get root => _root.root;

  Workspace get workspace => _root.workspace;

  //TODO: verify that this is a good equality check
  @override
  bool operator ==(Object other) =>
      other is ActiveContextRoot && root.path == other.root.path;

  @override
  int get hashCode => root.hashCode;
}
