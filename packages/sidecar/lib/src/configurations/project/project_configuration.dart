import 'package:checked_yaml/checked_yaml.dart';
import 'package:glob/glob.dart';
import 'package:yaml/yaml.dart';

import '../../models/models.dart';
import 'analysis_configuration.dart';
import 'analysis_package_configuration.dart';
import 'errors.dart';
import 'yaml_parsers/yaml_map_include_globs.dart';

class ProjectConfiguration {
  const ProjectConfiguration({
    this.lintPackages,
    this.assistPackages,
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
          assistPackages: parseAssistPackages(contentMap['edits'] as YamlMap?),
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
  final Map<PackageName, AssistPackageConfiguration>? assistPackages;
  final List<Glob>? _includes;
  final List<YamlSourceError> sourceErrors;

  List<Glob> get includeGlobs => _includes ?? [Glob('bin/**'), Glob('lib/**')];

  bool includes(String relativePath) =>
      includeGlobs.any((glob) => glob.matches(relativePath));

  AnalysisConfiguration? getConfiguration(Id id) {
    switch (id.type) {
      case IdType.lintRule:
        return lintPackages?[id.packageId]?.lints[id.id];
      case IdType.codeEdit:
        return assistPackages?[id.packageId]?.assists[id.id];
    }
  }
}

typedef PackageName = String;

Map<PackageName, AssistPackageConfiguration>? parseAssistPackages(
  YamlMap? map,
) =>
    parsePackages(map, IdType.codeEdit)?.map(
        (key, value) => MapEntry(key, value as AssistPackageConfiguration));

Map<PackageName, LintPackageConfiguration>? parseLintPackages(
  YamlMap? map,
) =>
    parsePackages(map, IdType.lintRule)
        ?.map((key, value) => MapEntry(key, value as LintPackageConfiguration));

Map<PackageName, AnalysisPackageConfiguration>? parsePackages(
  YamlMap? map,
  IdType type,
) {
  try {
    return map?.map((dynamic key, dynamic value) {
      if (value is YamlMap) {
        final config = AnalysisPackageConfiguration.fromYamlMap(
          value,
          type: type,
          packageName: key as String,
        );
        return MapEntry(key, config as LintPackageConfiguration);
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
