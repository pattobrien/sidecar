import 'package:checked_yaml/checked_yaml.dart';
import 'package:glob/glob.dart';
import 'package:yaml/yaml.dart';

import '../../models/models.dart';
import '../yaml_parsers/yaml_parsers.dart';
import 'analysis_configuration.dart';
import 'analysis_package_configuration.dart';
import 'errors.dart';

class ProjectConfiguration {
  const ProjectConfiguration({
    this.lintPackages,
    this.assistPackages,
    List<Glob>? includes,
    this.sourceErrors = const <YamlSourceError>[],
    required this.rawContent,
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
          rawContent: contents,
          lintPackages: _parseLintPackages(contentMap['lints'] as YamlMap?),
          assistPackages: _parseAssistPackages(contentMap['edits'] as YamlMap?),
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

  static Map<PackageName, AssistPackageConfiguration>? _parseAssistPackages(
    YamlMap? map,
  ) =>
      _parsePackages(map, type: IdType.codeEdit)?.map(
          (key, value) => MapEntry(key, value as AssistPackageConfiguration));

  static Map<PackageName, LintPackageConfiguration>? _parseLintPackages(
    YamlMap? map,
  ) =>
      _parsePackages(map, type: IdType.lintRule)?.map(
          (key, value) => MapEntry(key, value as LintPackageConfiguration));

  static Map<PackageName, AnalysisPackageConfiguration>? _parsePackages(
    YamlMap? map, {
    required IdType type,
  }) {
    try {
      return map?.nodes.map((dynamic key, dynamic value) {
        if (value is YamlMap) {
          key as YamlScalar;
          final config = AnalysisPackageConfiguration.fromYamlMap(
            value,
            type: type,
            packageName: key.value as String,
            packageNameSpan: key.span,
          );
          return MapEntry(key.value as String, config);
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

  final Map<PackageName, LintPackageConfiguration>? lintPackages;
  final Map<PackageName, AssistPackageConfiguration>? assistPackages;
  final List<Glob>? _includes;
  final List<YamlSourceError> sourceErrors;
  final String rawContent;

  List<Glob> get includeGlobs => _includes ?? [Glob('bin/**'), Glob('lib/**')];

  bool includes(String relativePath) =>
      includeGlobs.any((glob) => glob.matches(relativePath));

  LintConfiguration? getLintConfiguration(Id id) =>
      getConfiguration(id) as LintConfiguration?;

  AssistConfiguration? getAssistConfiguration(Id id) =>
      getConfiguration(id) as AssistConfiguration?;

  AnalysisConfiguration? getConfiguration(Id id) {
    switch (id.type) {
      case IdType.lintRule:
        return lintPackages?[id.packageId]?.lints[id.id];
      case IdType.codeEdit:
        return assistPackages?[id.packageId]?.assists[id.id];
    }
  }

  AnalysisConfiguration? getConfigurationForRule(SidecarBase rule) {
    switch (rule.type) {
      case IdType.lintRule:
        return lintPackages?[rule.packageName]?.lints[rule.code];
      case IdType.codeEdit:
        return assistPackages?[rule.packageName]?.assists[rule.code];
    }
  }
}

typedef PackageName = String;
