import 'package:glob/glob.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sidecar/sidecar.dart';
import 'package:sidecar/src/configuration/default_configuration.dart';

part 'plugin_configuration.g.dart';

@JsonSerializable(
  anyMap: true,
  checked: true,
  disallowUnrecognizedKeys: true,
  explicitToJson: true,
)
class PluginConfiguration {
  const PluginConfiguration({
    required this.rules,
    // required this.excludes,
    required this.includes,
  });
  final List<LintConfiguration>? rules;
  // @JsonKey(fromJson: patternsToGlobs, toJson: globsToPatterns)
  final List<String> includes;
  // @JsonKey(fromJson: patternsToGlobs, toJson: globsToPatterns)
  // final List<Glob> excludes;

  factory PluginConfiguration.fromJson(Map json) =>
      _$PluginConfigurationFromJson(json);

  Map<String, dynamic> toJson() => _$PluginConfigurationToJson(this);
}

// List<Glob> patternsToGlobs(List<String> patterns) =>
//     patterns.map((pattern) => (Glob(pattern))).toList();

// List<String> globsToPatterns(List<Glob> globs) =>
//     globs.map((glob) => glob.pattern).toList();
