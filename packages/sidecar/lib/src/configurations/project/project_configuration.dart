import 'package:checked_yaml/checked_yaml.dart';
import 'package:glob/glob.dart';
import 'package:json_annotation/json_annotation.dart';
import '../package/package_configuration.dart';
import 'edit_package_configuration.dart';
import 'lint_package_configuration.dart';

// final myLintConfig = projectConfig.lintPackages['riverpod_lints'].lints['prefer_consumer_widget'];

class ProjectConfiguration {
  const ProjectConfiguration({
    this.lintPackages,
    this.editPackages,
    List<String> includes = const ['lib/**', 'bin/**'],
  }) : _includes = includes;

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
          editPackages:
              parseEditPackageConfigurations(contentMap['edits'] as Map?),
        );
      },
    );
  }

  final Map<PackageName, LintPackageConfiguration>? lintPackages;
  final Map<PackageName, EditPackageConfiguration>? editPackages;
  final List<String> _includes;

  List<Glob> get includeGlobs => _includes.map<Glob>(Glob.new).toList();

  bool includes(String relativePath) {
    // final rootDirectory = analysisContext.contextRoot.root;
    // final relativePath = p.relative(path, from: rootDirectory.path);
    return includeGlobs.any((glob) => glob.matches(relativePath));
  }
}

typedef PackageName = String;

Map<PackageName, LintPackageConfiguration>? parseLintPackageConfigurations(
  Map? map,
) {
  return map?.map((dynamic key, dynamic value) {
    if (value is Map) {
      final config =
          LintPackageConfiguration.fromJson(value, packageName: key as String);
      return MapEntry(key, config);
    } else {
      // we want to throw an error if the package doesnt have a single lint declared
      throw UnimplementedError(
          'expected one or more lints for package $key in analysis_options.yaml');
    }
  });
}

Map<PackageName, EditPackageConfiguration>? parseEditPackageConfigurations(
  Map? map,
) {
  return map?.map((dynamic key, dynamic value) {
    if (value is Map) {
      final config =
          EditPackageConfiguration.fromJson(value, packageName: key as String);
      return MapEntry(key, config);
    } else {
      // we want to throw an error if the package doesnt have a single lint declared
      throw UnimplementedError(
          'expected one or more edits for package $key in analysis_options.yaml');
    }
  });
}
