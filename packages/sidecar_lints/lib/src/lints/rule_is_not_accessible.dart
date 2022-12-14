import 'package:analyzer/dart/ast/ast.dart';
import 'package:sidecar/sidecar.dart';

import '../constants.dart';

class RuleIsNotAccessible extends Rule with Lint {
  static const _id = 'rule_is_not_accessible';

  @override
  LintCode get code => const LintCode(_id, package: kPackageName);

  @override
  LintSeverity get defaultSeverity => LintSeverity.warning;

  @override
  void initializeVisitor(NodeRegistry registry) {
    // TODO: implement initializeVisitor
  }
}
