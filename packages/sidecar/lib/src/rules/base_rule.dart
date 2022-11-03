import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:glob/glob.dart';
import 'package:riverpod/riverpod.dart';

import '../analyzer/context/active_context.dart';
import '../analyzer/context/active_context_root.dart';
import '../analyzer/plugin/plugin.dart';
import '../analyzer/results/results.dart';
import '../configurations/configurations.dart';
import 'typedefs.dart';

// @Deprecated('switch to type-checking BaseRule type (e.g. LintRule, AssistRule)')
// enum RuleType { lint, assist }

abstract class BaseRule {
  String get code;
  LintPackageId get packageName;
  List<Glob>? get includes => null;
  MapDecoder? get jsonDecoder => null;

  late Ref _ref;
  late ActiveContextRoot _activeRoot;

  @internal
  late AnalysisConfiguration analysisConfiguration;

  List<SidecarAnnotatedNode> get annotatedNodes =>
      _ref.read(sidecarAnnotationsForRootProvider(_activeRoot));

  ActiveContext get context =>
      _ref.read(activeContextForRootProvider(_activeRoot));

  AnalysisSession get session => context.currentSession;

  Future<ResolvedUnitResult> getResolvedUnitResult(String path) async {
    final analysisSession = session;
    final unitResult = await analysisSession.getResolvedUnit(path);
    if (unitResult is ResolvedUnitResult) {
      return unitResult;
    }
    throw StateError('Failed to analyze $path');
  }

  @internal
  void initialize({
    required Ref ref,
    required ActiveContextRoot activeRoot,
    required AnalysisConfiguration configuration,
  }) {
    _ref = ref;
    _activeRoot = activeRoot;
    analysisConfiguration = configuration;
    if (jsonDecoder != null) {
      if (configuration.configuration == null) {
        //TODO: need to handle this
      } else {
        // try {
        //   _configuration = jsonDecoder!(configuration.configuration!);
        // } on SidecarAggregateException catch (e) {
        //   _errors.addAll(e.exceptions);
        // } catch (e, stackTrace) {
        //   rethrow;
        //   // final error = SidecarLintPackageException(
        //   // );
        //   // _errors.add(error);
        // }
      }
    }
  }
}
