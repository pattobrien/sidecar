export 'mixins.dart';
export '../src/rules/lint_severity.dart';
export '../src/rules/all_rules.dart';
export '../src/rules/base_rule.dart';
export '../src/rules/typedefs.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import '../src/rules/rules.dart';

abstract class SidecarAstVisitor extends GeneralizingAstVisitor<void>
    with BaseRule, BaseRuleVisitorMixin {}
