import 'package:glob/glob.dart';
import 'package:yaml/yaml.dart';

import '../../models/lint_rule.dart';
import 'edit_configuration.dart';

class EditPackageConfiguration {
  const EditPackageConfiguration({
    required this.packageName,
    required this.edits,
    this.includes,
  });

  factory EditPackageConfiguration.fromJson(
    Map json, {
    required String packageName,
  }) {
    return EditPackageConfiguration(
      packageName: packageName,
      edits: json.map<String, EditConfiguration>((dynamic key, dynamic value) {
        if (value is Map) {
          final configuration = value.containsKey('configuration')
              ? value['configuration'] as Map
              : <dynamic, dynamic>{};

          final severity = value.containsKey('severity')
              ? LintRuleTypeX.fromString(value['severity'] as String)
              : null;

          final includes = value.containsKey('includes')
              ? ((value['includes'] as YamlList).nodes)
                  .map<Glob>((e) => Glob(e.value as String))
                  .toList()
              : null;

          final enabled =
              value.containsKey('enabled') ? value['enabled'] as bool : null;

          return MapEntry(
            key as String,
            EditConfiguration(
              packageName: packageName,
              id: key,
              configuration: configuration,
              enabled: enabled,
              includes: includes,
              severity: severity,
            ),
          );
        } else if (value == null) {
          return MapEntry(
            key as String,
            EditConfiguration(
              packageName: packageName,
              id: key,
              configuration: <dynamic, dynamic>{},
            ),
          );
        } else {
          throw UnimplementedError(
              'could not parse package edits; expected Map was of type ${value.runtimeType}');
        }
      }),
    );
  }
  final String packageName;
  final Map<String, EditConfiguration> edits;
  final List<Glob>? includes;
}
