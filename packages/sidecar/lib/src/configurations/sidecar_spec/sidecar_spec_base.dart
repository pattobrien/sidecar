import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glob/glob.dart';

import '../../protocol/models/models.dart';
import '../../utils/json_utils/json_utils.dart';
import '../../utils/utils.dart';
import 'package_options.dart';
import 'rule_options.dart';

part 'sidecar_spec_base.g.dart';

/// Sidecar configuration defined at sidecar.yaml of a target package.
@JsonSerializable()
class SidecarSpec {
  const SidecarSpec({
    this.includes,
    this.excludes,
    this.lints,
    this.assists,
    this.data,
  });

  factory SidecarSpec.fromJson(Map json) => _$SidecarSpecFromJson(json);

  factory SidecarSpec.fromRuleCodes(
    List<RuleCode> codes, {
    List<Glob>? includes,
  }) {
    //TODO: assistPackages and dataPackages
    final lintPackages =
        codes.whereType<LintCode>().map((e) => e.package).toSet();
    final assistPackages =
        codes.whereType<AssistCode>().map((e) => e.package).toSet();
    return SidecarSpec(
      includes: includes ?? [Glob('lib/**.dart')],
      lints: {
        for (final lintPackage in lintPackages)
          lintPackage: LintPackageOptions(
            rules: {
              for (final lint
                  in codes.where((code) => code.package == lintPackage))
                lint.id: const LintOptions(),
            },
          ),
      },
    );
  }

  Map<String, dynamic> toJson() => _$SidecarSpecToJson(this);

  static final defaultIncludes = {Glob('lib/**.dart'), Glob('bin/**.dart')};

  static final defaultExcludes = <Glob>{};

  @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
  final List<Glob>? includes;

  @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
  final List<Glob>? excludes;

  final Map<String, LintPackageOptions>? lints;

  final Map<String, AssistPackageOptions>? assists;

  //TODO: change to data
  final Map<String, AssistPackageOptions>? data;

  RuleOptions? getConfigurationForCode(RuleCode code) {
    if (code is LintCode) {
      final package = lints?[code.package];
      final ruleConfig = package?.rules?[code.id];
      return ruleConfig;
    }
    if (code is AssistCode) {
      return assists?[code.package]?.rules?[code.id];
    }

    if (code is DataCode) {
      return data?[code.package]?.rules?[code.id];
    }
    throw UnimplementedError('INVALID CODE');
  }

  PackageOptions? getPackageConfigurationForCode(RuleCode code) {
    if (code is LintCode) {
      return lints?[code.package];
    }
    if (code is AssistCode) {
      return assists?[code.package];
    }
    if (code is DataCode) {
      return data?[code.package];
    }
    throw UnimplementedError('INVALID CODE');
  }

  String toYamlContent() {
    const yamlWriter = YamlWriter();
    return yamlWriter.write(toJson());
  }
}
