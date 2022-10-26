// ignore_for_file: use_setters_to_change_properties

import 'dart:async';

import 'package:analyzer/dart/analysis/results.dart' hide AnalysisResult;
import 'package:analyzer/dart/analysis/session.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glob/glob.dart';
import 'package:riverpod/riverpod.dart';
import 'package:source_span/source_span.dart';
import 'package:yaml/yaml.dart';

import '../analyzer/ast/ast.dart';
import '../analyzer/context/active_context_root.dart';
import '../analyzer/results/results.dart';
import '../configurations/builders/builders.dart';
import '../configurations/configurations.dart';
import 'rules.dart';

class ConfiguredRule {
  ConfiguredRule(
    this._ref, {
    required this.rule,
    required this.activeRoot,
    required this.ruleConfig,
    required this.packageConfig,
  });

  final BaseRule rule;
  final Ref _ref;
  final ActiveContextRoot activeRoot;
  final AnalysisConfiguration ruleConfig;
  final AnalysisPackageConfiguration packageConfig;

  String get code => rule.code;
  LintPackageId get packageName => rule.packageName;
  MapDecoder? get jsonDecoder => rule.jsonDecoder;
  List<SidecarConfigException>? get errors => _errors;

  @mustCallSuper
  Object get configuration => _configuration;

  late Object _configuration;
  final List<SidecarConfigException> _errors = [];

  List<SidecarAnnotatedNode> get annotatedNodes =>
      _ref.read(annotationsProvider(activeRoot));

  List<Glob>? get includes => null;

  void registerNodeProcessors(NodeLintRegistry registry) {}

  void initialize({
    required SourceSpan lintNameSpan,
    required AnalysisConfiguration? configuration,
  }) {
    if (jsonDecoder != null) {
      if (configuration == null) {
        //TODO: need to handle this
        // final error = SidecarLintPackageException(
        //   sourceSpan: lintNameSpan,
        //   message: '$code error: empty configuration',
        // );
        // _errors.add(error);
      } else {
        try {
          _configuration = jsonDecoder!(configuration.configuration!);
        } on SidecarAggregateException catch (e) {
          _errors.addAll(e.exceptions);
        } catch (e, stackTrace) {
          rethrow;
          // final error = SidecarLintPackageException(
          // );
          // _errors.add(error);
        }
      }
    }
  }

  Future<List<DartAnalysisResult>> computeDartAnalysisResults(
    ResolvedUnitResult unit,
  ) =>
      rule.computeDartAnalysisResults(unit);

  Future<List<EditResult>> computeSourceChanges(
    AnalysisSession session,
    AnalysisResult result,
  ) =>
      rule.computeSourceChanges(session, result);
}

class ConfiguredLintRule extends ConfiguredRule {
  ConfiguredLintRule(
    super.ref, {
    required super.activeRoot,
    required LintRule rule,
    required LintConfiguration ruleConfig,
    required AnalysisPackageConfiguration packageConfig,
  }) : super(rule: rule, ruleConfig: ruleConfig, packageConfig: packageConfig);

  LintSeverity get defaultType =>
      (ruleConfig as LintConfiguration).severity ??
      (rule as LintRule).defaultType;

  String? get url => (rule as LintRule).url;

  @override
  Future<List<DartAnalysisResult>> computeDartAnalysisResults(
    ResolvedUnitResult unit,
  ) async {
    final results = await rule.computeDartAnalysisResults(unit);
    return results.map((e) => e.copyWith(severity: defaultType)).toList();
  }
}

class ConfiguredAssistRule extends ConfiguredRule {
  ConfiguredAssistRule(
    super.ref, {
    required super.rule,
    required super.activeRoot,
    required super.ruleConfig,
    required super.packageConfig,
  });
}
