import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glob/glob.dart';

import '../../protocol/models/models.dart';
import '../../utils/json_utils/json_utils.dart';
import '../../utils/utils.dart';
import 'package_options.dart';
import 'rule_options.dart';

part 'sidecar_spec_base.g.dart';
part 'sidecar_spec_base.freezed.dart';

/// Sidecar configuration defined at sidecar.yaml of a target package.
@Freezed(
  unionKey: null,
  fromJson: false,
  toJson: true,
  unionValueCase: FreezedUnionCase.none,
)
class SidecarSpec with _$SidecarSpec {
  const factory SidecarSpec({
    @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
        List<Glob>? includes,
    @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
        List<Glob>? excludes,
    Map<String, LintPackageOptions>? lints,
    Map<String, AssistPackageOptions>? assists,
  }) = _SidecarSpec;

  const SidecarSpec._();

  // factory SidecarSpec.fromJson(Map<String, dynamic> json) =>
  //     _$SidecarSpecFromJson(json);

  factory SidecarSpec.empty() => const SidecarSpec();

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

  static final defaultIncludes = {Glob('lib/**.dart'), Glob('bin/**.dart')};

  static final defaultExcludes = <Glob>{};

  RuleOptions? getConfigurationForCode(RuleCode code) {
    if (code is LintCode) {
      final package = lints?[code.package];
      final ruleConfig = package?.rules?[code.id];
      return ruleConfig;
    }
    if (code is AssistCode) {
      return assists?[code.package]?.rules?[code.id];
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
    throw UnimplementedError('INVALID CODE');
  }

  String toYamlContent() {
    const yamlWriter = YamlWriter();
    return yamlWriter.write(toJson());
  }
}
