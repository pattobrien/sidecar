import 'package:checked_yaml/checked_yaml.dart';
import 'package:yaml/yaml.dart';

import '../exceptions/exceptions.dart';
import '../yaml_parsers/yaml_parsers.dart';
import 'enums.dart';
import 'errors.dart';
import 'package_options.dart';
import 'rule_options.dart';
import 'sidecar_spec_base.dart';

/// Create a SidecarSpec instance from raw file contents.
SidecarExceptionTuple<SidecarSpec> parseSidecarSpec(
  String contents, {
  Uri? fileUri,
}) {
  try {
    return checkedYamlDecode(contents, sourceUrl: fileUri, allowNull: true,
        (m) {
      final contentMap = m as YamlMap?;
      final includes = contentMap?.parseGlobIncludes();
      final excludes = contentMap?.parseGlobExcludes();
      final parsedErrors = <SidecarNewException>[];

      final assistPackages =
          (contentMap?['assists'] as YamlMap?)?.nodes.map((dynamic key, value) {
        final parsedPackage =
            _parsePackageOptions(value, fileUri, RuleType.assist);
        parsedErrors.addAll(parsedPackage.errors);
        return MapEntry((key as YamlScalar).value as String,
            parsedPackage.data as AssistPackageOptions);
      });

      final lintPackages =
          (contentMap?['lints'] as YamlMap?)?.nodes.map((dynamic key, value) {
        final parsedPackage =
            _parsePackageOptions(value, fileUri, RuleType.lint);
        parsedErrors.addAll(parsedPackage.errors);
        final entry = MapEntry((key as YamlScalar).value as String,
            parsedPackage.data as LintPackageOptions);
        return entry;
      });

      return SidecarExceptionTuple(
          SidecarSpec(
            includes: includes?.data,
            excludes: excludes?.data,
            assists: assistPackages,
            lints: lintPackages,
          ),
          [
            ...parsedErrors,
            ...?includes?.errors,
            ...?excludes?.errors,
          ]);
    });
  } catch (e) {
    return SidecarExceptionTuple(SidecarSpec.empty(), []);
  }
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

  final rulesNode = yamlMap?.nodes['rules'];

  if (rulesNode is! YamlMap?) {
    return const SidecarExceptionTuple(AssistPackageOptions(), []);
  }

  final assistPackages = rulesNode?.nodes.map((dynamic key, value) {
    final options = _parseRuleOptions(value, fileUri, RuleType.assist);
    errors.addAll(options.errors);
    return MapEntry(
        (key as YamlScalar).value as String, options.data as AssistOptions);
  });

  final packageOptions = AssistPackageOptions(
    includes: includes?.data,
    excludes: excludes?.data,
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

  final rulesNode = yamlMap?.nodes['rules'];

  if (rulesNode is! YamlMap?) {
    return const SidecarExceptionTuple(LintPackageOptions(), []);
  }

  final rulesMap = rulesNode?.nodes.map((dynamic key, value) {
    final options = _parseRuleOptions(value, fileUri, RuleType.lint);
    errors.addAll(options.errors);
    return MapEntry(
        (key as YamlScalar).value as String, options.data as LintOptions);
  });

  final packageOptions = LintPackageOptions(
    includes: includes?.data,
    excludes: excludes?.data,
    rules: rulesMap,
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
      includes: includes.data,
      excludes: excludes.data,
      severity: severity.data,
      enabled: enabled.data,
      configuration: yamlMap.nodes['configuration'] as YamlMap?,
    ),
    [
      ...includes.errors,
      ...excludes.errors,
      ...severity.errors,
      ...enabled.errors,
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
      includes: includes.data,
      excludes: excludes.data,
      enabled: enabled.data,
      configuration: yamlMap.nodes['configuration'] as YamlMap?,
    ),
    [
      ...includes.errors,
      ...excludes.errors,
      ...enabled.errors,
    ],
  );
}
