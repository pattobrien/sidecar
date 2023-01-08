// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes

import '../src/rules/rules.dart';

export '../src/rules/base_rule.dart' show QuickFix;
export '../src/rules/lint_severity.dart';

/// Create a lint.
abstract class LintRule = Rule with Lint;

/// Create an assist.
abstract class AssistRule = Rule with QuickAssist;

/// Capture data.
abstract class DataRule<T> = Rule with Data<T>;


// mixin Configuration on BaseRule {
//   Map<dynamic, dynamic>? get ruleConfiguration =>
//       sidecarSpec.getConfigurationForCode(code)?.configuration;
// }
