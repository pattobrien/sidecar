import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import '../src/rules/rules.dart';

abstract class SidecarVisitor extends AstVisitor<void>
    with BaseRule, BaseRuleVisitorMixin {}

abstract class SidecarAstVisitor extends GeneralizingAstVisitor<void>
    with BaseRule, BaseRuleVisitorMixin
    implements SidecarVisitor {}
