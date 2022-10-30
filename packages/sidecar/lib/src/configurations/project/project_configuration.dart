import 'dart:developer';

import 'package:checked_yaml/checked_yaml.dart';
import 'package:glob/glob.dart';
import 'package:riverpod/riverpod.dart';
import 'package:yaml/yaml.dart';

import '../../analyzer/server/log_delegate.dart';
import '../../rules/rules.dart';
import '../../utils/logger/logger.dart';
import '../builders/builders.dart';
import '../yaml_parsers/yaml_parsers.dart';
import 'analysis_configuration.dart';
import 'analysis_package_configuration.dart';
import 'errors.dart';

class ProjectConfiguration {
  const ProjectConfiguration({
    this.lintPackages,
    this.assistPackages,
    List<Glob>? includes,
    // this.sourceErrors = const <SidecarConfigException>[],
  }) : _includes = includes;

  factory ProjectConfiguration.parseFromSidecarYaml(String contents) {
    try {
      return checkedYamlDecode(contents, (m) {
        try {
          final contentMap = m as YamlMap?;
          final includesResult = contentMap!.parseGlobIncludes();
          return ProjectConfiguration(
            lintPackages: _parseLintPackages(contentMap['lints'] as YamlMap?),
            assistPackages:
                _parseAssistPackages(contentMap['assists'] as YamlMap?),
            includes: includesResult.item1,
          );
        } catch (e, stackTrace) {
          logger.severe('PROJCONFIG', e, stackTrace);
          throw const MissingSidecarYamlConfiguration();
        }
      });
    } catch (e, stackTrace) {
      logger.severe('PROJCONFIG unexpected error', e, stackTrace);
      throw UnimplementedError(
          'unexpected project config error: $e $stackTrace');
    }
  }

  List<SidecarConfigException> get combinedSourceErrors => [
        // ...sourceErrors,
        // ...?lintPackages?.values
        //     .map((e) => [
        //           ...e.sourceErrors,
        //           ...e.lints.values.map((e) => e.sourceErrors).expand((f) => f),
        //         ])
        //     .expand((e) => e),
        // ...?assistPackages?.values
        //     .map((e) => [
        //           ...e.sourceErrors,
        //           ...e.assists.values
        //               .map((e) => e.sourceErrors)
        //               .expand((f) => f),
        //         ])
        //     .expand((e) => e),
      ];

  static Map<PackageName, AnalysisPackageConfiguration>? _parsePackages(
    YamlMap? map, {
    required RuleType type,
  }) {
    try {
      return map?.nodes.map((dynamic key, dynamic value) {
        if (value is YamlMap) {
          key as YamlScalar;
          final config =
              AnalysisPackageConfiguration.fromYamlMap(value, type: type);
          return MapEntry(key.value as String, config);
        } else {
          // we want to throw an error if the package doesnt have a single lint declared

          //TODO: replace with a better error that we can catch
          throw UnimplementedError(
              'expected one or more assists for package $key in analysis_options.yaml');
        }
      });
    } catch (e) {
      //TODO: replace with a better error that we can catch
      throw InvalidSidecarConfiguration();
    }
  }

  static Map<PackageName, AssistPackageConfiguration>? _parseAssistPackages(
    YamlMap? map,
  ) =>
      _parsePackages(map, type: RuleType.assist)?.map(
          (key, value) => MapEntry(key, value as AssistPackageConfiguration));

  static Map<PackageName, LintPackageConfiguration>? _parseLintPackages(
    YamlMap? map,
  ) =>
      _parsePackages(map, type: RuleType.lint)?.map(
          (key, value) => MapEntry(key, value as LintPackageConfiguration));

  final Map<PackageName, LintPackageConfiguration>? lintPackages;
  final Map<PackageName, AssistPackageConfiguration>? assistPackages;
  final List<Glob>? _includes;
  // final List<SidecarConfigException> sourceErrors;

  List<Glob> get includeGlobs => _includes ?? [Glob('bin/**'), Glob('lib/**')];

  bool includes(String relativePath) =>
      includeGlobs.any((glob) => glob.matches(relativePath));

  AnalysisConfiguration? getConfigurationForRule(BaseRule rule) {
    if (rule is AssistRule) {
      return assistPackages?[rule.packageName]?.assists[rule.code];
    } else if (rule is LintRule) {
      return lintPackages?[rule.packageName]?.lints[rule.code];
    } else {
      throw UnimplementedError('getConfigurationForRule: unknown base type');
    }
  }
}

typedef PackageName = String;
