import 'package:yaml/yaml.dart';

import '../../rules/rules.dart';
import '../builders/builders.dart';
import '../project/errors.dart';

extension YamlMapSeverity on YamlMap {
  SidecarExceptionTuple<LintRuleType?> parseSeverity() {
    const key = 'severity';
    try {
      final severityValue = containsKey(key)
          ? LintRuleTypeX.fromString(value[key] as String)
          : null;
      return SidecarExceptionTuple<LintRuleType?>(severityValue, []);
    } on InvalidSeverityException {
      final invalidNode = nodes.keys
          .cast<YamlScalar>()
          .firstWhere((element) => element.value == key);
      return SidecarExceptionTuple<LintRuleType?>(null, [
        SidecarLintException(
          invalidNode,
          message:
              'Invalid value. Severity values are: warning, error, or info.',
        )
      ]);
    } catch (e) {
      return SidecarExceptionTuple<LintRuleType?>(null, [
        SidecarLintException(
          nodes.keys
              .cast<YamlScalar>()
              .firstWhere((element) => element.value == key),
          message:
              'Invalid value. Severity values are: warning, error, or info.',
        )
      ]);
    }
  }
}
