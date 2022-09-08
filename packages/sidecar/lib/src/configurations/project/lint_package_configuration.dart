import 'lint_configuration.dart';

class LintPackageConfiguration {
  const LintPackageConfiguration({
    required this.packageName,
    required this.lints,
  });
  final String packageName;
  final Map<String, LintConfiguration> lints;

  factory LintPackageConfiguration.fromJson(
    Map json, {
    required String packageName,
  }) {
    return LintPackageConfiguration(
      packageName: packageName,
      lints: json.map<String, LintConfiguration>((dynamic key, dynamic value) {
        if (value is Map) {
          return MapEntry(
              key as String,
              LintConfiguration(
                packageName: packageName,
                lintId: key,
                configuration: value['configuration'] as Map,
              ));
        } else {
          throw UnimplementedError(
              'could not parse package lints; expected Map was of type ${value.runtimeType}');
        }
      }),
    );
  }
}
