import 'package:checked_yaml/checked_yaml.dart';
import 'package:yaml/yaml.dart';

import '../../utils/logger/logger.dart';
import '../exceptions/exceptions.dart';
import '../project/errors.dart';
import '../yaml_parsers/yaml_parsers.dart';
import 'enums.dart';
import 'package_options.dart';
import 'rule_options.dart';
import 'sidecar_spec_base.dart';

SidecarExceptionTuple<SidecarSpec> parseSidecarSpecFromYaml(
  String contents, {
  Uri? fileUri,
}) {
  return checkedYamlDecode(
    contents,
    (m) {
      try {
        final contentMap = m as YamlMap?;
        final includes = contentMap?.parseGlobIncludes();
        final excludes = contentMap?.parseGlobExcludes();
        final parsedErrors = <SidecarNewException>[];

        final assistPackages = (contentMap?['assists'] as YamlMap?)
            ?.nodes
            .map((dynamic key, value) {
          final parsedPackage =
              parsePackageOptions(value, fileUri, RuleType.assist);
          parsedErrors.addAll(parsedPackage.item2);
          return MapEntry((key as YamlScalar).value as String,
              parsedPackage.item1 as AssistPackageOptions);
        });

        final lintPackages =
            (contentMap?['lints'] as YamlMap?)?.nodes.map((dynamic key, value) {
          final parsedPackage =
              parsePackageOptions(value, fileUri, RuleType.lint);
          parsedErrors.addAll(parsedPackage.item2);
          final entry = MapEntry((key as YamlScalar).value as String,
              parsedPackage.item1 as LintPackageOptions);
          return entry;
        });

        return SidecarExceptionTuple(
            SidecarSpec(
              includes: includes?.item1,
              excludes: excludes?.item1,
              assists: assistPackages,
              lints: lintPackages,
            ),
            [
              ...parsedErrors,
              ...?includes?.item2,
              ...?excludes?.item2,
            ]);
      } catch (e, stackTrace) {
        logger.severe('PROJCONFIG', e, stackTrace);
        throw const MissingSidecarYamlConfiguration();
      }
    },
    sourceUrl: fileUri,
  );
}

SidecarExceptionTuple<PackageOptions> parsePackageOptions(
  YamlNode? yamlNode,
  Uri? fileUri,
  RuleType ruleType,
) {
  final dynamic value = yamlNode?.value;
  if (value is YamlMap?) {
    return ruleType == RuleType.lint
        ? parseLintPackageOptions(value, fileUri)
        : parseAssistPackageOptions(value, fileUri);
  }
  throw StateError('unexpected lint rule package options type');
}

SidecarExceptionTuple<PackageOptions> parseAssistPackageOptions(
  YamlMap? yamlMap,
  Uri? fileUri,
) {
  final errors = <SidecarNewException>[];

  final includes = yamlMap?.parseGlobIncludes();
  final excludes = yamlMap?.parseGlobExcludes();

  final assistPackages = yamlMap?.nodes.map((dynamic key, value) {
    final options = parseRuleOptions(value, fileUri, RuleType.assist);
    errors.addAll(options.item2);
    return MapEntry(
        (key as YamlScalar).value as String, options.item1 as AssistOptions);
  });

  final packageOptions = AssistPackageOptions(
    includes: includes?.item1,
    excludes: excludes?.item1,
    rules: assistPackages,
  );

  return SidecarExceptionTuple(packageOptions, errors);
}

SidecarExceptionTuple<PackageOptions> parseLintPackageOptions(
  YamlMap? yamlMap,
  Uri? fileUri,
) {
  final errors = <SidecarNewException>[];

  final includes = yamlMap?.parseGlobIncludes();
  final excludes = yamlMap?.parseGlobExcludes();

  final lintMap = yamlMap?.nodes.map((dynamic key, value) {
    final options = parseRuleOptions(value, fileUri, RuleType.lint);
    errors.addAll(options.item2);
    return MapEntry(
        (key as YamlScalar).value as String, options.item1 as LintOptions);
  });

  final packageOptions = LintPackageOptions(
    includes: includes?.item1,
    excludes: excludes?.item1,
    rules: lintMap,
  );

  return SidecarExceptionTuple(packageOptions, errors);
}

SidecarExceptionTuple<RuleOptions> parseRuleOptions(
  YamlNode? yamlNode,
  Uri? fileUri,
  RuleType type,
) {
  if (yamlNode is YamlScalar) {
    if (yamlNode.value == null) {
      return const SidecarExceptionTuple(LintOptions(), []);
    } else if (yamlNode.value is bool) {
      return SidecarExceptionTuple(
        LintOptions(enabled: yamlNode.value as bool),
        [],
      );
    }
  }
  if (yamlNode is YamlMap) {
    return type == RuleType.lint
        ? parseLintRuleOptions(yamlNode, fileUri)
        : parseAssistRuleOptions(yamlNode, fileUri);
  }
  throw StateError('unexpected lint rule options type');
}

SidecarExceptionTuple<LintOptions> parseLintRuleOptions(
  YamlMap yamlMap,
  Uri? fileUri,
) {
  final includes = yamlMap.parseGlobIncludes();
  final excludes = yamlMap.parseGlobExcludes();
  final severity = yamlMap.parseSeverity();
  final enabled = yamlMap.parseEnabled();

  return SidecarExceptionTuple<LintOptions>(
    LintOptions(
      includes: includes.item1,
      excludes: excludes.item1,
      severity: severity.item1,
      enabled: enabled.item1,
      configuration: yamlMap.nodes['configuration'] as YamlMap?,
    ),
    [
      ...includes.item2,
      ...excludes.item2,
      ...severity.item2,
      ...enabled.item2,
    ],
  );
}

SidecarExceptionTuple<AssistOptions> parseAssistRuleOptions(
  YamlMap yamlMap,
  Uri? fileUri,
) {
  final includes = yamlMap.parseGlobIncludes();
  final excludes = yamlMap.parseGlobExcludes();
  final enabled = yamlMap.parseEnabled();

  return SidecarExceptionTuple<AssistOptions>(
    AssistOptions(
      includes: includes.item1,
      excludes: excludes.item1,
      enabled: enabled.item1,
      configuration: yamlMap.nodes['configuration'] as YamlMap?,
    ),
    [
      ...includes.item2,
      ...excludes.item2,
      ...enabled.item2,
    ],
  );
}
