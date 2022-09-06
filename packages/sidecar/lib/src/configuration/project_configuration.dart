import 'package:glob/glob.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sidecar/sidecar.dart';
import 'package:sidecar/src/configuration/default_configuration.dart';
import 'package:sidecar/src/configuration/edit_configuration.dart';

part 'project_configuration.g.dart';

@JsonSerializable(
  anyMap: true,
  checked: true,
  disallowUnrecognizedKeys: true,
  explicitToJson: true,
)
class ProjectConfiguration {
  const ProjectConfiguration({
    this.rules,
    this.edits,
    required this.includes,
  });
  final List<LintConfiguration>? rules;
  final List<EditConfiguration>? edits;
  // @JsonKey(fromJson: patternsToGlobs, toJson: globsToPatterns)
  final List<String> includes;
  // @JsonKey(fromJson: patternsToGlobs, toJson: globsToPatterns)
  // final List<Glob> excludes;

  factory ProjectConfiguration.fromJson(Map json) =>
      _$ProjectConfigurationFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectConfigurationToJson(this);
}

// List<Glob> patternsToGlobs(List<String> patterns) =>
//     patterns.map((pattern) => (Glob(pattern))).toList();

// List<String> globsToPatterns(List<Glob> globs) =>
//     globs.map((glob) => glob.pattern).toList();
