import 'package:glob/glob.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:yaml/yaml.dart';

import '../../utils/json_utils/glob_json_util.dart';
import '../builders/new_exceptions.dart';
import 'analysis_configuration.dart';

part 'analysis_package_configuration.g.dart';

abstract class AnalysisPackageConfiguration {
  const AnalysisPackageConfiguration();
}

@JsonSerializable(anyMap: true, explicitToJson: true, includeIfNull: false)
class LintPackageConfiguration extends AnalysisPackageConfiguration {
  //
  const LintPackageConfiguration({
    this.lints,
    this.includes,
  }) : errors = const [];

  factory LintPackageConfiguration.fromJson(Object? yamlMap) {
    if (yamlMap is YamlMap?) {
      return LintPackageConfiguration._(
        lints: yamlMap?.nodes
            .map<String, LintConfiguration?>((dynamic key, value) {
          final yamlKey = key as YamlScalar;
          if (value == null) return MapEntry(yamlKey.value.toString(), null);
          final config = LintConfiguration.fromJson(value);
          return MapEntry(yamlKey.value.toString(), config);
        }),
      );
    }
    throw UnimplementedError();
  }

  const LintPackageConfiguration._({
    this.lints,
    this.includes,
    this.errors = const [],
  });

  Map<dynamic, dynamic> toJson() {
    final includesEntry =
        includes != null ? MapEntry('includes', globsToString(includes)) : null;
    final lintsEntries = lints != null ? lints!.map(MapEntry.new) : null;
    final map = <dynamic, dynamic>{};
    if (includesEntry != null) map.addEntries([includesEntry]);
    if (lintsEntries != null) {
      map.addAll(lints!.map<dynamic, dynamic>(
          (key, value) => MapEntry<dynamic, dynamic>(key, value?.toJson())));
    }
    return map;
  }

  final Map<String, LintConfiguration?>? lints;
  @JsonKey(toJson: globsToString, fromJson: globsFromString)
  final List<Glob>? includes;
  final List<SidecarNewException> errors;
}

@JsonSerializable(anyMap: true, explicitToJson: true, includeIfNull: false)
class AssistPackageConfiguration extends AnalysisPackageConfiguration {
  //
  const AssistPackageConfiguration({
    this.assists,
    this.includes,
  }) : errors = const [];

  factory AssistPackageConfiguration.fromJson(Object? yamlMap) {
    if (yamlMap is YamlMap?) {
      return AssistPackageConfiguration._(
        assists: yamlMap?.nodes
            .map<String, AssistConfiguration>((dynamic key, value) {
          final yamlKey = key as YamlScalar;
          final config = AssistConfiguration.fromJson(value);
          return MapEntry(yamlKey.value.toString(), config);
        }),
      );
    }
    throw UnimplementedError();
  }
  const AssistPackageConfiguration._({
    this.assists,
    this.includes,
    this.errors = const [],
  });

  Map<dynamic, dynamic> toJson() => _$AssistPackageConfigurationToJson(this);

  final Map<String, AssistConfiguration?>? assists;
  @JsonKey(toJson: globsToString, fromJson: globsFromString)
  final List<Glob>? includes;
  final List<SidecarNewException> errors;
}
