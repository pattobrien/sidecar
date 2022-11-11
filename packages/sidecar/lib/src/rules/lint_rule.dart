import 'dart:async';

import '../analyzer/ast/general_visitor.dart';
import '../analyzer/context/unit_context.dart';
import '../protocol/models/models.dart';
import '../protocol/protocol.dart';
import 'base_rule.dart';
import 'lint_severity.dart';
import 'visitor.dart';

abstract class LintRule extends BaseRule {
  Uri? get url => null;
  LintSeverity get defaultSeverity => LintSeverity.info;
}

mixin Compute on LintRule {
  FutureOr<List<LintResult>> computeLints(UnitContext context);
}

mixin LintVisitor on LintRule {
  SidecarVisitor initializeVisitor(NodeRegistry registry);
}

typedef SidecarVisitorCreator = SidecarVisitor Function();
