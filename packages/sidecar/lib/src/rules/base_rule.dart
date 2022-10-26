import 'dart:async';

import 'package:analyzer/dart/analysis/results.dart' hide AnalysisResult;
import 'package:analyzer/dart/analysis/session.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:glob/glob.dart';
import 'package:riverpod/riverpod.dart';

import '../analyzer/ast/ast.dart';
import '../analyzer/context/active_context_root.dart';
import '../analyzer/results/results.dart';
import '../configurations/builders/exceptions.dart';
import '../configurations/configurations.dart';
import 'typedefs.dart';

enum RuleType { lint, assist }

abstract class BaseRule {
  String get code;
  LintPackageId get packageName;

  List<Glob>? get includes => null;
  MapDecoder? get jsonDecoder => null;

  @mustCallSuper
  Object get configuration => _configuration;

  late Ref _ref;
  late Object _configuration;
  late ActiveContextRoot _activeRoot;

  @internal
  late AnalysisConfiguration analysisConfiguration;

  List<SidecarAnnotatedNode> get annotatedNodes =>
      _ref.read(annotationsProvider(_activeRoot));

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

  //TODO: can we remove the future here?
  Future<List<AnalysisResult>> computeDartAnalysisResults(
    ResolvedUnitResult unit,
  ) =>
      Future.value([]);

  Future<List<EditResult>> computeSourceChanges(
    AnalysisSession session,
    AnalysisResult result,
  ) =>
      Future.value(<EditResult>[]);
}
