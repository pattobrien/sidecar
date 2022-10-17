import '../../rules/rules.dart';

class SidecarLintRule extends LintRule {
  @override
  String get code => 'invalid_lint_configuration';

  @override
  LintPackageId get packageName => 'sidecar';
}

class SidecarFieldLintRule extends LintRule {
  @override
  String get code => 'invalid_field_configuration';

  @override
  LintPackageId get packageName => 'sidecar';
}
