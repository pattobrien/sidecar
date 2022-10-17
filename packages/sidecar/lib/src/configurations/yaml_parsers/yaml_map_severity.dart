import 'package:dartz/dartz.dart';
import 'package:yaml/yaml.dart';

import '../../rules/rules.dart';
import '../builders/builders.dart';
import '../project/errors.dart';

extension YamlMapSeverity on YamlMap {
  Either<LintRuleType?, List<SidecarConfigException>> parseSeverity() {
    const key = 'severity';
    try {
      return left(containsKey(key)
          ? LintRuleTypeX.fromString(value[key] as String)
          : null);
    } on InvalidSeverityException catch (e) {
      return right([
        SidecarFieldException(nodes.keys
                .cast<YamlScalar>()
                .firstWhere((element) => element.value == key)

            // sourceSpan: errorSpan,
            // message:
            //     '${e.invalidValue} is an invalid value. Severity values are: warning, error, or info.',
            )
      ]);
    } catch (e) {
      return right([
        SidecarFieldException(nodes.keys
                .cast<YamlScalar>()
                .firstWhere((element) => element.value == key)
            // sourceSpan: errorSpan,
            // message:
            //     'Invalid value. Severity values are: warning, error, or info.',
            )
      ]);
    }
  }
}
