import 'lint_configuration.dart';

class LintPackageConfiguration {
  const LintPackageConfiguration({
    required this.packageName,
    required this.lints,
  });
  final String packageName;
  final Map<LintName, LintConfiguration> lints;

  factory LintPackageConfiguration.fromJson(
    Map json, {
    required String packageName,
  }) {
    // final packageName = json['packageName'] as String;
    // final lintConfigurations = json['lints'] as Map<String, dynamic>;
    return LintPackageConfiguration(
      packageName: packageName,
      lints: json.map((key, value) {
        return MapEntry(
            key as String,
            LintConfiguration(
              packageName: packageName,
              lintId: key,
              configuration: value['configuration'],
            ));
      }),
    );
  }
}

typedef LintName = String;
