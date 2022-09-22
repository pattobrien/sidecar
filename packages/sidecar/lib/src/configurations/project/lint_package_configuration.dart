import 'package:glob/glob.dart';

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
          final hasConfiguration = value.containsKey('configuration');
          // final config = hasConfiguration ? ;
          return MapEntry(
            key as String,
            LintConfiguration(
              packageName: packageName,
              lintId: key,
              configuration: hasConfiguration
                  ? value['configuration'] as Map
                  : <dynamic, dynamic>{},
            ),
          );
        } else if (value == null) {
          return MapEntry(
            key as String,
            LintConfiguration(
              packageName: packageName,
              lintId: key,
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
