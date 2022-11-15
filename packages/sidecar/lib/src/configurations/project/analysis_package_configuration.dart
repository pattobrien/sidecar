import 'package:glob/glob.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:yaml/yaml.dart';

import '../../utils/json_utils/glob_json_util.dart';
import '../exceptions/exceptions.dart';
import '../yaml_parsers/yaml_parsers.dart';
import 'analysis_configuration.dart';

part 'analysis_package_configuration.g.dart';

abstract class AnalysisPackageConfiguration {
  const AnalysisPackageConfiguration();
  List<Glob>? get includes;
  List<SidecarNewException> get errors;

  bool includesMatch(String relativePath) =>
      includes?.any((glob) => glob.matches(relativePath)) ?? false;
}

@JsonSerializable(anyMap: true, explicitToJson: true, includeIfNull: false)
class LintPackageConfiguration extends AnalysisPackageConfiguration {
  //
  const LintPackageConfiguration({
    this.lints,
    this.includes,
  }) : errors = const [];

  factory LintPackageConfiguration.fromJson(Map<dynamic, dynamic> yamlMap) {
    if (yamlMap is YamlMap) {
      final includes = yamlMap.parseGlobIncludes();
      return LintPackageConfiguration._(
        includes: includes.item1,
        errors: includes.item2,
        lints:
            yamlMap.nodes.map<String, LintConfiguration?>((dynamic key, value) {
          final yamlKey = key as YamlScalar;
          if (value.value == null) {
            return MapEntry(yamlKey.value.toString(), null);
          }
          final config = LintConfiguration.fromJson(value);
          return MapEntry(yamlKey.value.toString(), config);
        }),
      );
    }
    throw UnimplementedError(
        'LintPackageConfiguration was invalid type: ${yamlMap.runtimeType}');
  }

  const LintPackageConfiguration._({
    this.lints,
    this.includes,
    this.errors = const [],
  });

  Map<dynamic, dynamic> toJson() {
    final includesEntry = includes != null
        ? MapEntry('includes', globsToStrings(includes))
        : null;
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
  @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
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
      final includes = yamlMap?.parseGlobIncludes();
      return AssistPackageConfiguration._(
        includes: includes?.item1,
        errors: [...?includes?.item2],
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
  @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
  final List<Glob>? includes;
  final List<SidecarNewException> errors;
}
