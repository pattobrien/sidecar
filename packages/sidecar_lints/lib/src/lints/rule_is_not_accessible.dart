import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:collection/collection.dart';
import 'package:sidecar/sidecar.dart';

import '../../sidecar_lints.dart';
import '../constants.dart';
import '../utils.dart';

class RuleIsNotAccessible extends LintRule {
  static const _id = 'rule_is_not_accessible';
  static const _message = 'Rule is not accessible from public API';

  @override
  LintCode get code => const LintCode(_id, package: kPackageName);

  @override
  LintSeverity get defaultSeverity => LintSeverity.warning;

  @override
  void initializeVisitor(NodeRegistry registry) {
    // registry.addCompilationUnit(this);
    registry.addClassDeclaration(this);
  }

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    if (!isSidecarRule(node)) return;
    // final libPath = '';
    // final libUnit = await context.currentSession.getResolvedUnit(libPath);

    reportAstNode(node.name, message: _message);
  }
  // @override
  // void visitClassDeclaration(ClassDeclaration node) {
  //   if (!isSidecarRule(node)) return;

  //   final data = context.data
  //       .firstWhereOrNull((element) => element.code == kPublicRulesCode)
  //       ?.data;

  //   if (data == null) return;
  //   final classes = data.first as List<ClassElement>;

  //   if (classes.any((clazz) => clazz == node.declaredElement2)) return;

  //   reportAstNode(node.name, message: _message);
  // }
}
