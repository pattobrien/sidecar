import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glob/glob.dart';

import '../../protocol/models/models.dart';
import '../../utils/json_utils/json_utils.dart';
import '../../utils/utils.dart';
import 'package_options.dart';
import 'rule_options.dart';

part 'sidecar_spec_base.g.dart';

@JsonSerializable(anyMap: true, includeIfNull: false)
class SidecarSpec {
  const SidecarSpec({
    this.includes,
    this.excludes,
    this.lints,
    this.assists,
  });

  factory SidecarSpec.fromJson(Map json) => _$SidecarSpecFromJson(json);

  Map<String, dynamic> toJson() => _$SidecarSpecToJson(this);

  static final defaultIncludes = {Glob('lib/**'), Glob('bin/**')};

  @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
  final List<Glob>? includes;
  @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
  final List<Glob>? excludes;
  final Map<String, LintPackageOptions>? lints;
  final Map<String, AssistPackageOptions>? assists;

  RuleOptions? getConfigurationForCode(RuleCode code) {
    if (code is LintCode) {
      final package = lints?[code.package];
      final ruleConfig = package?.rules?[code.code];
      return ruleConfig;
    }
    if (code is AssistCode) {
      return assists?[code.package]?.rules?[code.code];
    }
    throw UnimplementedError();
  }

  PackageOptions? getPackageConfigurationForCode(RuleCode code) {
    if (code is LintCode) {
      return lints?[code.package];
    }
    if (code is AssistCode) {
      return assists?[code.package];
    }
    throw UnimplementedError();
  }

  String toYamlContent() {
    const yamlWriter = YamlWriter();
    return yamlWriter.write(toJson());
  }
}
