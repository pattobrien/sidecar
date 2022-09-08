import 'package:checked_yaml/checked_yaml.dart';
import 'package:glob/glob.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sidecar/sidecar.dart';
import 'package:sidecar/src/configuration/default_configuration.dart';
import 'package:sidecar/src/configuration/edit_configuration.dart';
import 'package:sidecar/src/configuration/lint_configuration.dart';
import 'package:yaml/yaml.dart';

part 'project_configuration.g.dart';

typedef PackageName = dynamic;

@JsonSerializable(anyMap: true)
class ProjectConfiguration {
  const ProjectConfiguration({
    this.lints,
    this.edits,
    this.includes = const [
      'lib/**',
      'test/**',
      'bin/**',
    ],
  });
  factory ProjectConfiguration.fromJson(Map json) =>
      _$ProjectConfigurationFromJson(json);

  factory ProjectConfiguration.fromYaml(String content) {
    return checkedYamlDecode<ProjectConfiguration>(
      content,
      (m) =>
          ProjectConfiguration.fromJson(m!['sidecar'] as Map<dynamic, dynamic>),
    );
  }

  @JsonKey(fromJson: lintConfigFromJson)
  final Map<PackageName, LintConfiguration>? lints;

  @JsonKey(fromJson: editConfigFromJson)
  final Map<PackageName, EditConfiguration>? edits;

  final List<String> includes;

  // @JsonKey(fromJson: patternsToGlobs, toJson: globsToPatterns)
  // final List<Glob> excludes;

  // Map<String, dynamic> toJson() => _$ProjectConfigurationToJson(this);
}

// List<Glob> patternsToGlobs(List<String> patterns) =>
//     patterns.map((pattern) => (Glob(pattern))).toList();

// List<String> globsToPatterns(List<Glob> globs) =>
//     globs.map((glob) => glob.pattern).toList();

Map<PackageName, LintConfiguration>? lintConfigFromJson(Map? json) {
  final map = json?.map<String, dynamic>((dynamic key, dynamic value) {
    if (key is String) {
      return MapEntry<String, dynamic>(key, value);
    } else {
      throw UnimplementedError('lintConfigFromJson: expected String');
    }
  });
  return map?.map<PackageName, LintConfiguration>((key, dynamic value) {
    if (value == null) {
      return MapEntry<PackageName, LintConfiguration>(
        key,
        LintConfiguration(
          id: key,
          configuration: null,
          enabled: true,
        ),
      );
    }
    if (value is bool) {
      return MapEntry<PackageName, LintConfiguration>(
        key,
        LintConfiguration(
          id: key,
          configuration: null,
          enabled: value,
        ),
      );
    }
    if (value is Map<dynamic, dynamic>) {
      final dynamic enabledValue = value['enabled'];
      if (enabledValue is bool) {
        return MapEntry<PackageName, LintConfiguration>(
          key,
          LintConfiguration(
            id: key,
            configuration: value,
            enabled: enabledValue,
          ),
        );
      } else {
        return MapEntry<PackageName, LintConfiguration>(
          key,
          LintConfiguration(
            id: key,
            configuration: value,
            enabled: true,
          ),
        );
      }
    }
    throw UnimplementedError(
        'lint configuration is not correct: type is ${value.runtimeType}');
  });
}

Map<PackageName, EditConfiguration>? editConfigFromJson(
  Map? json,
) {
  final map = json?.map<String, dynamic>((dynamic key, dynamic value) {
    if (key is String) {
      return MapEntry<String, dynamic>(key, value);
    } else {
      throw UnimplementedError('lintConfigFromJson: expected String');
    }
  });
  return map?.map<PackageName, EditConfiguration>((key, dynamic value) {
    if (value == null) {
      return MapEntry<PackageName, EditConfiguration>(
        key,
        EditConfiguration(
          id: key,
          configuration: null,
          enabled: true,
        ),
      );
    }
    if (value is bool) {
      return MapEntry<PackageName, EditConfiguration>(
        key,
        EditConfiguration(
          id: key,
          configuration: null,
          enabled: value,
        ),
      );
    }
    if (value is Map<dynamic, dynamic>) {
      final dynamic enabledValue = value['enabled'];
      if (enabledValue is bool) {
        return MapEntry<PackageName, EditConfiguration>(
          key,
          EditConfiguration(
            id: key,
            configuration: value,
            enabled: enabledValue,
          ),
        );
      } else {
        return MapEntry<PackageName, EditConfiguration>(
          key,
          EditConfiguration(
            id: key,
            configuration: value,
            enabled: true,
          ),
        );
      }
    }
    throw UnimplementedError('edit configuration is not correct');
  });
}
