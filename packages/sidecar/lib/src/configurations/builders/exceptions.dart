import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:source_span/source_span.dart';
import 'package:yaml/yaml.dart';

import '../../utils/utils.dart';

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
}

class SidecarFieldException implements SidecarConfigException {
  const SidecarFieldException(
    YamlScalar packageNode,
  ) : _packageNode = packageNode;

  final YamlScalar _packageNode;

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
      AnalysisErrorType.LINT,
      sourceSpan.location,
      message,
      'invalid_field_configuration',
      correction: correction,
      contextMessages: [],
      //TODO: url: _url,
    );
  }
}

class SidecarLintPackageException implements SidecarConfigException {
  const SidecarLintPackageException(
    YamlScalar packageNode,
  ) : _packageNode = packageNode;

  final YamlScalar _packageNode;

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
      AnalysisErrorType.LINT,
      sourceSpan.location,
      message,
      'incorrect_package_configuration',
      correction: correction,
      contextMessages: [],
      //TODO: url: _url,
    );
  }
}

// String missingFieldMessage(String fieldName) =>
//     '\'$fieldName\' field is missing from configuration.';

// String incorrectTypeFieldMessage(String fieldName, Type expectedType) =>
//     'Expected type for field \'$fieldName\' is $expectedType.';