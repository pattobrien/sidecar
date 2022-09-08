import 'package:sidecar_cli/src/configurations/project/edit_configuration.dart';

import 'lint_configuration.dart';

class EditPackageConfiguration {
  const EditPackageConfiguration({
    required this.packageName,
    required this.lints,
  });
  final String packageName;
  final Map<LintName, EditConfiguration> lints;

  factory EditPackageConfiguration.fromJson(
    Map json, {
    required String packageName,
  }) {
    // final packageName = json['packageName'] as String;
    // final lintConfigurations = json['lints'] as Map<String, dynamic>;
    return EditPackageConfiguration(
      packageName: packageName,
      lints: json.map((key, value) {
        return MapEntry(
            key as String,
            EditConfiguration(
              packageName: packageName,
              editId: key,
              configuration: value['configuration'],
            ));
      }),
    );
  }
}

typedef LintName = String;
