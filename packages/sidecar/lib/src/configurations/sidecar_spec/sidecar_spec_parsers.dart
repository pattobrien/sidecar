import 'package:checked_yaml/checked_yaml.dart';
import 'package:yaml/yaml.dart';

import '../../utils/logger/logger.dart';
import '../exceptions/exceptions.dart';
import '../yaml_parsers/yaml_parsers.dart';
import 'enums.dart';
import 'errors.dart';
import 'package_options.dart';
import 'rule_options.dart';
import 'sidecar_spec_base.dart';

/// Create a SidecarSpec instance from raw file contents.
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
              _parsePackageOptions(value, fileUri, RuleType.assist);
          parsedErrors.addAll(parsedPackage.item2);
          return MapEntry((key as YamlScalar).value as String,
              parsedPackage.item1 as AssistPackageOptions);
        });

        final lintPackages =
            (contentMap?['lints'] as YamlMap?)?.nodes.map((dynamic key, value) {
          final parsedPackage =
              _parsePackageOptions(value, fileUri, RuleType.lint);
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

SidecarExceptionTuple<PackageOptions> _parsePackageOptions(
  YamlNode? yamlNode,
  Uri? fileUri,
  RuleType ruleType,
) {
  final dynamic value = yamlNode?.value;
  if (value is YamlMap?) {
    return ruleType == RuleType.lint
        ? _parseLintPackageOptions(value, fileUri)
        : _parseAssistPackageOptions(value, fileUri);
  }
  throw StateError('unexpected lint rule package options type');
}

SidecarExceptionTuple<PackageOptions> _parseAssistPackageOptions(
  YamlMap? yamlMap,
  Uri? fileUri,
) {
  final errors = <SidecarNewException>[];

  final includes = yamlMap?.parseGlobIncludes();
  final excludes = yamlMap?.parseGlobExcludes();

  final rulesNode = yamlMap?.nodes['rules'] as YamlMap?;

  final assistPackages = rulesNode?.nodes.map((dynamic key, value) {
    final options = _parseRuleOptions(value, fileUri, RuleType.assist);
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

SidecarExceptionTuple<PackageOptions> _parseLintPackageOptions(
  YamlMap? yamlMap,
  Uri? fileUri,
) {
  final errors = <SidecarNewException>[];

  final includes = yamlMap?.parseGlobIncludes();
  final excludes = yamlMap?.parseGlobExcludes();

  final rulesNode = yamlMap?.nodes['rules'] as YamlMap?;

  final lintMap = rulesNode?.nodes.map((dynamic key, value) {
    final options = _parseRuleOptions(value, fileUri, RuleType.lint);
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

SidecarExceptionTuple<RuleOptions> _parseRuleOptions(
  YamlNode? yamlNode,
  Uri? fileUri,
  RuleType type,
) {
  if (yamlNode is YamlScalar) {
    if (yamlNode.value == null) {
      final options =
          type == RuleType.lint ? const LintOptions() : const AssistOptions();
      return SidecarExceptionTuple(options, []);
    } else if (yamlNode.value is bool) {
      final options = type == RuleType.lint
          ? LintOptions(enabled: yamlNode.value as bool)
          : AssistOptions(enabled: yamlNode.value as bool);
      return SidecarExceptionTuple(options, []);
    }
  }
  if (yamlNode is YamlMap) {
    return type == RuleType.lint
        ? _parseLintRuleOptions(yamlNode, fileUri)
        : _parseAssistRuleOptions(yamlNode, fileUri);
  }
  throw StateError('unexpected lint rule options type');
}

SidecarExceptionTuple<LintOptions> _parseLintRuleOptions(
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

SidecarExceptionTuple<AssistOptions> _parseAssistRuleOptions(
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
