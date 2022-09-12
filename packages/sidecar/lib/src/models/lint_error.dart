// ignore_for_file: implementation_imports

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod/riverpod.dart';

import '../ast/ast.dart';
import '../reporter/i_error_reporter.dart';
import 'reported_lint_error.dart';

enum LintErrorType { info, warning, error }

abstract class LintError {
  LintError(this.ref);

  String get code;
  String get message;
  LintErrorType get defaultType;

  String get packageName;

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

  void registerNodeProcessors(NodeLintRegistry registry);

  void reportedAstNode(AstNode? node) {
    if (node != null) {
      reporter.reportedLint(node, this);
    }
  }

  ReportedLintError computeLintHighlight(
    ReportedLintError reportedLintError,
  ) =>
      reportedLintError;

  Future<List<plugin.PrioritizedSourceChange>> computeFixes(
    ReportedLintError lint,
  ) =>
      Future.value([]);
}

typedef GetFixes = List<plugin.PrioritizedSourceChange> Function(
    ResolvedUnitResult unit);

extension LintErrorTypeX on LintErrorType {
  plugin.AnalysisErrorSeverity get analysisError {
    switch (this) {
      case LintErrorType.info:
        return plugin.AnalysisErrorSeverity.INFO;
      case LintErrorType.warning:
        return plugin.AnalysisErrorSeverity.WARNING;
      case LintErrorType.error:
        return plugin.AnalysisErrorSeverity.ERROR;
    }
  }
}

typedef MapDecoder = Object Function(Map json);
