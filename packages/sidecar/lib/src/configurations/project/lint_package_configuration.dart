import 'package:analyzer/diagnostic/diagnostic.dart';
import 'package:glob/glob.dart';
import 'package:yaml/yaml.dart';

import '../../../sidecar.dart';
import '../../models/lint_rule.dart';
import 'lint_configuration.dart';

class LintPackageConfiguration {
  const LintPackageConfiguration({
    required this.packageName,
    required this.lints,
    this.includes,
  });

  factory LintPackageConfiguration.fromJson(
    Map json, {
    required String packageName,
  }) {
    return LintPackageConfiguration(
      packageName: packageName,
      lints: json.map<String, LintConfiguration>((dynamic key, dynamic value) {
        if (value is Map) {
          final lintConfigurationErrors = <YamlSourceError>[];
          // try {
          final configuration = value.containsKey('configuration')
              ? value['configuration'] as Map
              : <dynamic, dynamic>{};
          LintRuleType? severity;
          try {
            severity = value.containsKey('severity')
                ? LintRuleTypeX.fromString(value['severity'] as String)
                : null;
          } on InvalidSeverityException catch (e) {
            final val = value as YamlMap;
            final span = val.nodes.keys
                .cast<YamlScalar>()
                .firstWhere((element) => element.value == 'severity')
                .span;

            lintConfigurationErrors.add(YamlSourceError(
                sourceSpan: span,
                message:
                    '${e.invalidValue} is an invalid severity (values are warning, error, or info)'));
          }

          final includes = value.containsKey('includes')
              ? ((value['includes'] as YamlList).nodes)
                  .map<Glob>((e) => Glob(e.value as String))
                  .toList()
              : null;

          final enabled =
              value.containsKey('enabled') ? value['enabled'] as bool : null;

          return MapEntry(
            key as String,
            LintConfiguration(
              packageName: packageName,
              id: key,
              includes: includes,
              severity: severity,
              enabled: enabled,
              configuration: configuration,
              sourceErrors: lintConfigurationErrors,
            ),
          );
          // } on LintConfigurationException catch (e) {
          //   lintConfigurationErrors.addAll(e.messages);
          // }
          // if (lintConfigurationErrors.isNotEmpty) {
          //   throw PackageConfigurationException(lintConfigurationErrors);
          // }
        } else if (value == null) {
          return MapEntry(
            key as String,
            LintConfiguration(
              packageName: packageName,
              id: key,
              configuration: <dynamic, dynamic>{},
            ),
          );
        } else {
          throw UnimplementedError(
            'could not parse package lints; expected Map was of type ${value.runtimeType}',
          );
        }
      }),
    );
  }
  final String packageName;
  final Map<String, LintConfiguration> lints;
  final List<Glob>? includes;
}
