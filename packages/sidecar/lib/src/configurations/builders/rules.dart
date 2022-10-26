import '../../rules/rules.dart';

class SidecarLintRule extends LintRule {
  @override
  String get code => 'invalid_lint_configuration';

  @override
  LintPackageId get packageName => 'sidecar';

  @override
  LintSeverity get defaultSeverity => LintSeverity.warning;
}

class SidecarFieldLintRule extends LintRule {
  @override
  String get code => 'invalid_field_configuration';

  @override
  LintPackageId get packageName => 'sidecar';

  @override
  LintSeverity get defaultSeverity => LintSeverity.warning;
}

class SidecarPackageRule extends LintRule {
  @override
  String get code => 'invalid_package_configuration';

  @override
  LintPackageId get packageName => 'sidecar';

  @override
  LintSeverity get defaultSeverity => LintSeverity.warning;
}
