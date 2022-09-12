// ignore_for_file: implementation_imports

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod/riverpod.dart';

import '../ast/ast.dart';
import '../reporter/i_error_reporter.dart';
import 'detected_lint.dart';

abstract class LintRule {
  LintRule(this.ref);

  String get code;
  String get packageName;
  String get message;

  LintRuleType get defaultType => LintRuleType.info;
  String? get url => null;

  @mustCallSuper
  Object get configuration => _configuration;

  MapDecoder get jsonDecoder => (_) => <dynamic, dynamic>{};

  late Object _configuration;

  final ProviderContainer ref;

  late IErrorReporter reporter;

  void initialize({
    required Map? configurationContent,
    required IErrorReporter reporter,
  }) {
    if (configurationContent != null) {
      _configuration = jsonDecoder(configurationContent);
    }
    this.reporter = reporter;
  }

  void registerNodeProcessors(NodeLintRegistry registry) {}

  void reportAstNode(AstNode? node) {
    if (node != null) {
      reporter.reportAstNode(node, this);
    }
  }

  DetectedLint computeLintHighlight(DetectedLint lint) => lint;

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

typedef MapDecoder = Object Function(Map json);
