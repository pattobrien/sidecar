import 'package:dartz/dartz.dart';
import 'package:yaml/yaml.dart';

import '../../rules/rules.dart';
import '../project/errors.dart';
import 'yaml_source_error.dart';

extension YamlMapSeverity on YamlMap {
  Either<LintRuleType?, List<YamlSourceError>> parseSeverity() {
    try {
      return left(containsKey('severity')
          ? LintRuleTypeX.fromString(value['severity'] as String)
          : null);
    } on InvalidSeverityException catch (e) {
      final errorSpan = nodes.keys
          .cast<YamlScalar>()
          .firstWhere((element) => element.value == 'severity')
          .span;
      return right([
        YamlSourceError(
          sourceSpan: errorSpan,
          message:
              '${e.invalidValue} is an invalid value. Severity values are: warning, error, or info.',
        )
      ]);
    } catch (e) {
      final errorSpan = nodes.keys
          .cast<YamlScalar>()
          .firstWhere((element) => element.value == 'severity')
          .span;
      return right([
        YamlSourceError(
          sourceSpan: errorSpan,
          message:
              'Invalid value. Severity values are: warning, error, or info.',
        )
      ]);
    }
  }
}
