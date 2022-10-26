import 'package:yaml/yaml.dart';

import '../../rules/rules.dart';
import '../builders/builders.dart';
import '../project/errors.dart';

extension YamlMapSeverity on YamlMap {
  SidecarExceptionTuple<LintSeverity?> parseSeverity() {
    const key = 'severity';
    try {
      final severityValue = containsKey(key)
          ? LintSeverityX.fromString(value[key] as String)
          : null;
      return SidecarExceptionTuple<LintSeverity?>(severityValue, []);
      // } on InvalidSeverityException {
      //   final invalidNode = nodes.keys
      //       .cast<YamlScalar>()
      //       .firstWhere((element) => element.value == key);
      //   return SidecarExceptionTuple<LintRuleType?>(null, [
      //     SidecarLintException(
      //       invalidNode,
      //       message:
      //           'Invalid value. Severity values are: warning, error, or info.',
      //     )
      //   ]);
    } catch (e) {
      return SidecarExceptionTuple<LintSeverity?>(null, [
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
