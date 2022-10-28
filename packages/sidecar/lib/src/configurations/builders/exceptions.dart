import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:source_span/source_span.dart';
import 'package:yaml/yaml.dart';

import '../../analyzer/results/results.dart';
import '../../rules/rules.dart';
import '../../utils/utils.dart';
import 'rules.dart';

class SidecarException implements Exception {}

class SidecarAggregateException implements Exception {
  const SidecarAggregateException(this.exceptions);
  final List<SidecarConfigException> exceptions;

  List<AnalysisError> get analysisErrors =>
      exceptions.map((e) => e.toAnalysisError()).toList();
}

abstract class SidecarConfigException {
  SourceSpan get sourceSpan;
  String get message;
  String get correction;
  AnalysisError toAnalysisError();
  AnalysisResult toAnalysisResult();
}

class SidecarFieldException implements SidecarConfigException {
  const SidecarFieldException(
    YamlScalar packageNode, {
    String? message,
    String? correction,
  })  : _message = message,
        _correction = correction,
        _packageNode = packageNode;

  final YamlScalar _packageNode;
  final String? _message;
  final String? _correction;

  SidecarFieldLintRule get rule => SidecarFieldLintRule();

  @override
  SourceSpan get sourceSpan => _packageNode.span;

  @override
  String get message => _message ?? 'Package configuration is incorrect.';

  @override
  String get correction =>
      _correction ?? 'Visit the lint documentation to make a correction.';

  @override
  AnalysisError toAnalysisError() {
    return AnalysisError(
      AnalysisErrorSeverity.ERROR,
      AnalysisErrorType.HINT,
      sourceSpan.location,
      message,
      rule.code,
      correction: correction,
      // contextMessages: [],
      //TODO: url: _url,
    );
  }

  @override
  AnalysisResult toAnalysisResult() => AnalysisResult.lint(
        rule: rule,
        span: AnalysisSourceSpan(
          path: sourceSpan.sourceUrl!.path,
          source: sourceSpan,
        ),
        message: message,
        severity: LintSeverity.warning,
      );
}

class SidecarLintException implements SidecarConfigException {
  const SidecarLintException(
    YamlScalar packageNode, {
    String? message,
    String? correction,
  })  : _message = message,
        _correction = correction,
        _packageNode = packageNode;

  final YamlScalar _packageNode;
  final String? _message;
  final String? _correction;

  LintRule get rule => SidecarLintRule();

  @override
  SourceSpan get sourceSpan => _packageNode.span;

  @override
  String get message => _message ?? 'Lint configuration is incorrect.';

  @override
  String get correction =>
      _correction ?? 'Visit the lint documentation to make a correction.';

  @override
  AnalysisError toAnalysisError() {
    return AnalysisError(
      AnalysisErrorSeverity.ERROR,
      AnalysisErrorType.HINT,
      sourceSpan.location,
      message,
      'invalid_lint_configuration',
      correction: correction,
      // contextMessages: [],
      //TODO: url: _url,
    );
  }

  @override
  LintResult toAnalysisResult() {
    return LintResult(
      span: AnalysisSourceSpan(
        path: sourceSpan.sourceUrl!.path,
        source: sourceSpan,
      ),
      rule: rule,
      message: message,
      correction: correction,
      severity: LintSeverity.warning,
    );
  }
}

class SidecarLintPackageException implements SidecarConfigException {
  const SidecarLintPackageException(
    YamlScalar packageNode,
  ) : _packageNode = packageNode;

  final YamlScalar _packageNode;

  LintRule get rule => SidecarFieldLintRule();

  @override
  SourceSpan get sourceSpan => _packageNode.span;

  @override
  String get message => 'Package configuration is incorrect.';

  @override
  String get correction => 'Visit the lint documentation to make a correction.';

  @override
  AnalysisError toAnalysisError() {
    return AnalysisError(
      AnalysisErrorSeverity.ERROR,
      AnalysisErrorType.HINT,
      sourceSpan.location,
      message,
      'incorrect_package_configuration',
      correction: correction,
      // contextMessages: [],
      //TODO: url: _url,
    );
  }

  @override
  AnalysisResult toAnalysisResult() {
    return AnalysisResult.lint(
      span: AnalysisSourceSpan(
        path: sourceSpan.sourceUrl!.path,
        source: sourceSpan,
      ),
      rule: rule,
      message: message,
      correction: correction,
      severity: LintSeverity.warning,
    );
  }
}

// String missingFieldMessage(String fieldName) =>
//     '\'$fieldName\' field is missing from configuration.';

// String incorrectTypeFieldMessage(String fieldName, Type expectedType) =>
//     'Expected type for field \'$fieldName\' is $expectedType.';