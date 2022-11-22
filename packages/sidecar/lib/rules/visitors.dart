import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import '../src/rules/rules.dart';

abstract class SidecarVisitor extends AstVisitor<void>
    with BaseRule, BaseRuleVisitorMixin {}

abstract class SidecarGeneralizingAstVisitor
    extends GeneralizingAstVisitor<void>
    with BaseRule, BaseRuleVisitorMixin
    implements SidecarVisitor {}

abstract class SidecarRecursiveAstVisitor extends RecursiveAstVisitor<void>
    with BaseRule, BaseRuleVisitorMixin
    implements SidecarVisitor {}

abstract class SidecarThrowingAstVisitor extends ThrowingAstVisitor<void>
    with BaseRule, BaseRuleVisitorMixin
    implements SidecarVisitor {}

abstract class SidecarUnifyingAstVisitor extends UnifyingAstVisitor<void>
    with BaseRule, BaseRuleVisitorMixin
    implements SidecarVisitor {}

abstract class SidecarSimpleAstVisitor extends SimpleAstVisitor<void>
    with BaseRule, BaseRuleVisitorMixin
    implements SidecarVisitor {}
