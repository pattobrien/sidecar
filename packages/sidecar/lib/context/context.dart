import 'package:analyzer/dart/analysis/analysis_options.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:package_config/package_config_types.dart';

import '../src/configurations/configurations.dart';
import '../src/protocol/models/analysis_result.dart';
import '../src/protocol/models/data_result.dart';

/// A snapshot of states from the current Sidecar analysis context.
abstract class SidecarContext {
  // should we allow access to all configurations?
  SidecarSpec get sidecarSpec;

  ///
  Set<TotalDataResult> get data;

  /// Current file.
  // ResolvedUnitResult get currentUnit;

  /// Return the context root from which this context was created.
  // ContextRoot get contextRoot;
  Uri get targetRoot;

  /// Return the package_config.json from which this context was created.
  // PackageConfig get packageConfig;

  /// The analysis options used to control the way the code is analyzed.
  AnalysisOptions get analysisOptions;

  /// Return the currently active analysis session.
  AnalysisSession get currentSession;

  /// The root directory of the SDK against which files of this context are
  /// analyzed, or `null` if the SDK is not directory based.
  Folder? get sdkRoot;

  /// Return a [Future] that completes after pending file changes are applied,
  /// so that [currentSession] can be used to compute results.
  ///
  /// The value is the set of all files that are potentially affected by
  /// the pending changes. This set can be both wider than the set of analyzed
  /// files (because it may include files imported from other packages, and
  /// which are on the import path from a changed file to an analyzed file),
  /// and narrower than the set of analyzed files (because only files that
  /// were previously accessed are considered to be known and affected).
  Future<List<String>> applyPendingFileChanges();

  /// Schedules the file with the [path] to be read before producing new
  /// analysis results.
  ///
  /// The file is expected to be a Dart file, reporting non-Dart files, such
  /// as configuration files `analysis_options.yaml`, `package_config.json`,
  /// etc will not re-create analysis contexts.
  ///
  /// This will invalidate any previously returned [AnalysisSession], to
  /// get a new analysis session apply pending file changes:
  /// ```dart
  /// analysisContext.changeFile(...);
  /// await analysisContext.applyPendingFileChanges();
  /// var analysisSession = analysisContext.currentSession;
  /// var resolvedUnit = analysisSession.getResolvedUnit(...);
  /// ```
  void changeFile(String path);

  SidecarContext copyWith({
    Set<TotalDataResult>? data,
  });
}
