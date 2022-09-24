import 'package:glob/glob.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:recase/recase.dart';
import 'package:yaml/yaml.dart';

import '../../models/lint_rule.dart';
import 'errors.dart';

class LintConfiguration {
  const LintConfiguration({
    required this.packageName,
    required this.id,
    this.configuration,
    this.enabled,
    this.includes,
    this.severity,
    this.sourceErrors = const <YamlSourceError>[],
  });

  final String packageName;
  final String id;

  final bool? enabled;
  final YamlMap? configuration;
  final List<Glob>? includes;
  final LintRuleType? severity;

  final List<YamlSourceError> sourceErrors;
}

extension LintConfigurationX on LintConfiguration {
  String get filePath => '$packageName/$packageName.dart';
  String get className => ReCase(id).pascalCase;
}
