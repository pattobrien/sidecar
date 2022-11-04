// ignore_for_file: implementation_imports

import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/src/workspace/workspace.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'analyzed_file.dart';

part 'active_context_root.freezed.dart';

@freezed
@immutable
class ActiveContextRoot with _$ActiveContextRoot {
  const factory ActiveContextRoot(
    ContextRoot contextRoot, {

    /// Indicates the package that explicitly activates Sidecar as a plugin.
    required bool isExplicitlyEnabledRoot,
  }) = _ActiveContextRoot;

  const ActiveContextRoot._();

  List<AnalyzedFile> analyzedFiles() => contextRoot
      .analyzedFiles()
      .map((e) => AnalyzedFile(this, Uri.parse(e)))
      .toList();

  List<Resource> get excluded => contextRoot.excluded;

  Iterable<String> get excludedPaths => contextRoot.excludedPaths;

  List<Resource> get included => contextRoot.included;

  Iterable<String> get includedPaths => contextRoot.includedPaths;

  bool isAnalyzed(String path) => contextRoot.isAnalyzed(path);

  File? get optionsFile => contextRoot.optionsFile;

  File? get packagesFile => contextRoot.packagesFile;

  ResourceProvider get resourceProvider => contextRoot.resourceProvider;

  Folder get root => contextRoot.root;

  Workspace get workspace => contextRoot.workspace;

  //TODO: verify that this is a good equality check
  @override
  bool operator ==(Object other) =>
      other is ActiveContextRoot && root.path == other.root.path;

  @override
  int get hashCode => root.hashCode;
}
