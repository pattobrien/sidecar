import 'package:checked_yaml/checked_yaml.dart';
import 'package:glob/glob.dart';
import 'package:yaml/yaml.dart';

import 'edit_configuration.dart';
import 'edit_package_configuration.dart';
import 'errors.dart';
import 'lint_configuration.dart';
import 'lint_package_configuration.dart';
import 'yaml_parsers/yaml_map_include_globs.dart';

class ProjectConfiguration {
  const ProjectConfiguration({
    this.lintPackages,
    this.editPackages,
    List<Glob>? includes,
    this.sourceErrors = const <YamlSourceError>[],
  }) : _includes = includes;

  factory ProjectConfiguration.parse(
    String contents, {
    required Uri sourceUrl,
  }) {
    return checkedYamlDecode(
      contents,
      (m) {
        YamlMap contentMap;
        try {
          contentMap = m!['sidecar'] as YamlMap;
        } catch (e) {
          throw const MissingSidecarConfiguration();
        }
        final sourceErrors = <YamlSourceError>[];
        return ProjectConfiguration(
          lintPackages: parseLintPackages(contentMap['lints'] as YamlMap?),
          editPackages: parseEditPackages(contentMap['edits'] as YamlMap?),
          includes: contentMap.parseGlobIncludes().fold((l) => l, (r) {
            sourceErrors.addAll(r);
            return null;
          }),
          sourceErrors: sourceErrors,
        );
      },
      sourceUrl: sourceUrl,
    );
  }

  final Map<PackageName, LintPackageConfiguration>? lintPackages;
  final Map<PackageName, EditPackageConfiguration>? editPackages;
  final List<Glob>? _includes;
  final List<YamlSourceError> sourceErrors;

  List<Glob> get includeGlobs => _includes ?? [Glob('bin/**'), Glob('lib/**')];

  bool includes(String relativePath) =>
      includeGlobs.any((glob) => glob.matches(relativePath));

  LintConfiguration? lintConfiguration(String packageId, String lintId) =>
      lintPackages?[packageId]?.lints[lintId];

  EditConfiguration? editConfiguration(String packageId, String editId) =>
      editPackages?[packageId]?.edits[editId];
}

typedef PackageName = String;

Map<PackageName, LintPackageConfiguration>? parseLintPackages(YamlMap? map) {
  try {
    return map?.map((dynamic key, dynamic value) {
      if (value is YamlMap) {
        final config = LintPackageConfiguration.fromYamlMap(value,
            packageName: key as String);
        return MapEntry(key, config);
      } else {
        // we want to throw an error if the package doesnt have a single lint declared
        //TODO: replace with a better error that we can catch
        throw UnimplementedError(
            'expected one or more lints for package $key in analysis_options.yaml');
      }
    });
  } on PackageConfigurationException catch (e) {
    //TODO: replace with a better error that we can catch
    throw UnimplementedError('PackageConfigurationException error!!! $e');
  }
}

Map<PackageName, EditPackageConfiguration>? parseEditPackages(YamlMap? map) {
  try {
    return map?.map((dynamic key, dynamic value) {
      if (value is YamlMap) {
        final config = EditPackageConfiguration.fromYamlMap(value,
            packageName: key as String);
        return MapEntry(key, config);
      } else {
        // we want to throw an error if the package doesnt have a single lint declared

        //TODO: replace with a better error that we can catch
        throw UnimplementedError(
            'expected one or more edits for package $key in analysis_options.yaml');
      }
    });
  } catch (e) {
    //TODO: replace with a better error that we can catch
    throw InvalidSidecarConfiguration();
  }
}
