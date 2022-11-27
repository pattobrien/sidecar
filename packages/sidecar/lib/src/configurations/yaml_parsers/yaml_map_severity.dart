import 'package:yaml/yaml.dart';

import '../../rules/rules.dart';
import '../exceptions/exceptions.dart';
import '../sidecar_spec/errors.dart';

extension YamlMapSeverity on YamlMap {
  SidecarExceptionTuple<LintSeverity?> parseSeverity() {
    const key = 'severity';
    try {
      final severityValue = containsKey(key)
          ? LintSeverityX.fromString(value[key] as String)
          : null;
      return SidecarExceptionTuple<LintSeverity?>(severityValue, []);
    } catch (e) {
      return SidecarExceptionTuple<LintSeverity?>(null, [
        SidecarNewException.lintField(
          correction: '',
          sourceSpan: nodes.keys
              .cast<YamlScalar>()
              .firstWhere((element) => element.value == key)
              .span,
          message:
              'Invalid value. Severity values are: warning, error, or info.',
        )
      ]);
    }
  }
}
