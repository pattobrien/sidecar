import 'package:checked_yaml/checked_yaml.dart';
import 'package:glob/glob.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:yaml/yaml.dart';

import '../../protocol/models/models.dart';
import '../../rules/rules.dart';
import '../../utils/json_utils/glob_json_util.dart';
import '../../utils/logger/logger.dart';
import '../../utils/yaml_writer.dart';
import '../builders/config_exceptions.dart';
import '../yaml_parsers/yaml_parsers.dart';
import 'analysis_configuration.dart';
import 'analysis_package_configuration.dart';
import 'errors.dart';

part 'project_configuration.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ProjectConfiguration {
  const ProjectConfiguration({
    this.lintPackages,
    this.assistPackages,
    List<Glob>? includes,
  })  : _includes = includes,
        errors = const <SidecarNewException>[];

  const ProjectConfiguration._({
    this.lintPackages,
    this.assistPackages,
    List<Glob>? includes,
    this.errors = const <SidecarNewException>[],
  }) : _includes = includes;

  factory ProjectConfiguration.fromYaml(
    String contents, {
    Uri? fileUri,
  }) {
    try {
      return checkedYamlDecode(
        contents,
        (m) {
          try {
            final contentMap = m as YamlMap?;
            final includesResult = contentMap!.parseGlobIncludes();
            return ProjectConfiguration._(
              lintPackages: _parseLintPackages(contentMap['lints'] as YamlMap?),
              assistPackages:
                  _parseAssistPackages(contentMap['assists'] as YamlMap?),
              includes: includesResult.item1,
              errors: includesResult.item2,
            );
          } catch (e, stackTrace) {
            logger.severe('PROJCONFIG', e, stackTrace);
            throw const MissingSidecarYamlConfiguration();
          }
        },
        sourceUrl: fileUri,
      );
    } catch (e, stackTrace) {
      logger.severe('PROJCONFIG unexpected error', e, stackTrace);
      throw UnimplementedError(
          'unexpected project config error: $e $stackTrace');
    }
  }

  factory ProjectConfiguration.fromJson(Map<String, dynamic> json) =>
      _$ProjectConfigurationFromJson(json);

  Map<dynamic, dynamic> toJson() => _$ProjectConfigurationToJson(this);

  String toYamlContent() {
    const yamlWriter = YamlWriter();
    return yamlWriter.write(toJson());
  }

  List<SidecarNewException> get allErrors => [
        ...errors,
        ...?lintPackages?.values
            .map((e) => [
                  ...e.errors,
                  ...?e.lints?.values
                      .map((e) => e?.errors ?? [])
                      .expand((f) => f),
                ])
            .expand((e) => e),
        ...?assistPackages?.values
            .map((e) => [
                  ...e.errors,
                  ...?e.assists?.values
                      .map((e) => e?.errors ?? [])
                      .expand((f) => f),
                ])
            .expand((e) => e),
      ];

  static Map<PackageName, AnalysisPackageConfiguration>? _parsePackages(
    YamlMap? map, {
    required RuleType type,
  }) {
    try {
      return map?.nodes.map((dynamic key, dynamic value) {
        if (value is YamlMap) {
          key as YamlScalar;
          final config = type == RuleType.lint
              ? LintPackageConfiguration.fromJson(value)
              : AssistPackageConfiguration.fromJson(value);
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

  @JsonKey(name: 'lints')
  final Map<PackageName, LintPackageConfiguration>? lintPackages;

  @JsonKey(name: 'assists')
  final Map<PackageName, AssistPackageConfiguration>? assistPackages;

  @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
  final List<Glob>? _includes;

  @JsonKey(defaultValue: <SidecarNewException>[])
  final List<SidecarNewException> errors;

  List<Glob> get includeGlobs => _includes ?? [Glob('bin/**'), Glob('lib/**')];

  bool includes(String relativePath) =>
      includeGlobs.any((glob) => glob.matches(relativePath));

  AnalysisConfiguration? getConfigurationForRule(BaseRule rule) {
    if (rule is AssistRule) {
      return assistPackages?[rule.packageName]?.assists?[rule.code];
    } else if (rule is LintRule) {
      return lintPackages?[rule.packageName]?.lints?[rule.code];
    } else {
      throw UnimplementedError('getConfigurationForRule: unknown base type');
    }
  }
}

typedef PackageName = String;
