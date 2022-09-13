// ignore_for_file: implementation_imports

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod/riverpod.dart';
import 'package:yaml/yaml.dart';

import '../../sidecar.dart';
import '../ast/ast.dart';
import '../reporter/i_error_reporter.dart';
import 'detected_lint.dart';
import 'typedefs.dart';

abstract class LintRule {
  LintRule(this.ref);

  String get code;
  String get packageName;
  String get message;

  LintRuleType get defaultType => LintRuleType.info;
  String? get url => null;

  @mustCallSuper
  Object get configuration => _configuration;

  MapDecoder? get jsonDecoder => null;

  final ProviderContainer ref;

  late Object _configuration;

  void initialize({required Map? configurationContent}) {
    if (jsonDecoder != null) {
      if (configurationContent == null) {
        throw EmptyConfiguration();
      } else {
        try {
          _configuration = jsonDecoder!(configurationContent);
        } catch (e, stackTrace) {
          throw IncorrectConfiguration(e, stackTrace);
        }
      }
    }
  }

  @Deprecated(
      'Moving away from registering node processors. Use computeAnalysisError instead.')
  void registerNodeProcessors(NodeLintRegistry registry) {}

  List<DetectedLint> computeAnalysisError(ResolvedUnitResult unit);

  SourceSpan computeLintHighlight(DetectedLint lint) => lint.sourceSpan;

  Future<List<plugin.PrioritizedSourceChange>> computeCodeEdits(
    DetectedLint lint,
  ) =>
      Future.value([]);
}

enum LintRuleType { info, warning, error }

extension LintErrorTypeX on LintRuleType {
  plugin.AnalysisErrorSeverity get analysisError {
    switch (this) {
      case LintRuleType.info:
        return plugin.AnalysisErrorSeverity.INFO;
      case LintRuleType.warning:
        return plugin.AnalysisErrorSeverity.WARNING;
      case LintRuleType.error:
        return plugin.AnalysisErrorSeverity.ERROR;
    }
  }
}
