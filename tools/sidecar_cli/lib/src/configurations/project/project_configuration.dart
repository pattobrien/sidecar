import 'package:checked_yaml/checked_yaml.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sidecar_cli/src/configurations/package/package_configuration.dart';
import 'package:sidecar_cli/src/configurations/project/package_configuration.dart';

// final myLintConfig = projectConfig.lintPackages['riverpod_lints'].lints['prefer_consumer_widget'];

class ProjectConfiguration {
  const ProjectConfiguration({
    this.lintPackages,
    // this.editPackages,
    // required this.packageName,
  });

  factory ProjectConfiguration.parse(
    String contents,
  ) {
    return checkedYamlDecode(
      contents,
      (m) {
        final contentMap = m!['sidecar'] as Map;
        return ProjectConfiguration(
          lintPackages:
              parseLintPackageConfigurations(contentMap['lints'] as Map?),
          // edits: editConfigFromJson(contentMap['edits'] as Map?, packageName),
          // packageName: packageName,
        );
      },
    );
  }

  final Map<PackageName, LintPackageConfiguration>? lintPackages;
  // final Map<PackageName, EditPackageConfiguration>? editPackages;
  // final String packageName;
}

typedef PackageName = String;

Map<PackageName, LintPackageConfiguration>? parseLintPackageConfigurations(
  Map? map,
  // String packageName,
) {
  return map?.map((key, value) {
    if (value is Map) {
      final config = LintPackageConfiguration.fromJson(value, packageName: key);
      return MapEntry(key, config);
    } else {
      // we want to throw an error if the package doesnt have a single lint declared
      throw UnimplementedError(
          'expected one or more lints for package $key in analysis_options.yaml');
    }
  });
}
