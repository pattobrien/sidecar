// ignore_for_file: implementation_imports

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';

import 'package:riverpod/riverpod.dart';

import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';

import 'reported_lint_error.dart';
import '../reporter/i_error_reporter.dart';
import '../ast/ast.dart';

enum LintErrorType { info, warning, error }

abstract class LintError {
  LintError(this.ref);

  String get code;
  String get message;
  LintErrorType get defaultType;
  // GetFixes? get getFixes;
  Map<dynamic, dynamic> get yamlConfig => <dynamic, dynamic>{};

  final ProviderContainer ref;

  late IErrorReporter reporter;

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
    ReportedLintError reportedLintError,
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
