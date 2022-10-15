import 'code_edit.dart';
import 'lint_rule.dart';
import 'sidecar_base.dart';

typedef CodeEditId = String;
typedef LintRuleId = String;
typedef LintPackageId = String;

typedef MapDecoder = Object Function(Map json);

typedef LintRuleConstructor = LintRule Function();

typedef CodeEditConstructor = AssistRule Function();

typedef SidecarBaseConstructor = SidecarBase Function();
