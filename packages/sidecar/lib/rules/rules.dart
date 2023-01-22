import '../src/rules/rules.dart';

export '../src/rules/base_rule.dart' show QuickFix, SidecarBaseConstructor;
export '../src/rules/lint_severity.dart' show LintSeverity;

/// Create a lint.
abstract class LintRule = Rule with Lint;

/// Create an assist.
abstract class AssistRule = Rule with QuickAssist;

/// Capture data.
@Deprecated('')
abstract class DataRule = Rule with Data;


// mixin Configuration on BaseRule {
//   Map<dynamic, dynamic>? get ruleConfiguration =>
//       sidecarSpec.getConfigurationForCode(code)?.configuration;
// }
