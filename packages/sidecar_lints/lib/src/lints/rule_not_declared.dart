import 'package:analyzer/dart/ast/ast.dart';
import 'package:sidecar/sidecar.dart';

import 'constants.dart';

class RuleNotDeclared extends Rule with Lint, QuickFix {
  static const _id = 'rule_not_declared';

  @override
  LintCode get code => const LintCode(_id, package: kPackageName, url: kUri);

  @override
  void initializeVisitor(NodeRegistry registry) {
    registry.addClassDeclaration(this);
  }

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    //
  }
}
