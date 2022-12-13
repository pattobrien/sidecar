import 'package:analyzer/dart/ast/ast.dart';
import 'package:collection/collection.dart';
import 'package:sidecar/sidecar.dart';

import 'constants.dart';

class MissingVisitMethodRegistration extends Rule with Lint {
  static const _id = 'missing_visit_method_registration';

  @override
  LintCode get code => const LintCode(_id, package: kPackageName, url: kUri);

  @override
  void initializeVisitor(NodeRegistry registry) {
    registry.addClassDeclaration(this);
  }

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    if (isSidecarRule(node)) {
      final properties = node.members.whereType<MethodDeclaration>();

      final initializerMethod = properties.firstWhereOrNull(
          (element) => element.name.name == 'initializeVisitor');
      final visitMethods = properties
          .where((element) => element.name.name.contains('visit'))
          .map((e) => e.name.name)
          .toSet();
      final initializerBody = initializerMethod?.body;
      if (initializerBody is BlockFunctionBody) {
        // if (initializerBody.block.statements is! MethodInvocation) return;
      }

      if (initializerBody is ExpressionFunctionBody) {
        final methodNames = getVisitMethodNames(initializerBody.expression);
        visitMethods.removeAll(methodNames);
      }
      if (visitMethods.isNotEmpty) {
        // reportToken(node.name2,
        //     message:
        //         'found Rule class; initializer: ${initializerMethod?.body.toSource()} visit methods: $visitMethods');
        reportToken(node.name2,
            message: 'found Rule class; visit methods: $visitMethods');
      }

      // check for expressionFunctionBody or blockFunctionBody

      // node.members.where((element) => false);
    }
  }
}

Set<String> getVisitMethodNames(Expression expression) {
  if (expression is MethodInvocation) {
    return <String>{
      if (expression.methodName.name.contains('add'))
        expression.methodName.name.replaceFirst('add', 'visit')
    };
  }
  if (expression is CascadeExpression) {
    final methods = expression.cascadeSections.whereType<MethodInvocation>();
    return methods
        .where((element) => element.methodName.name.contains('add'))
        .map((e) => e.methodName.name.replaceFirst('add', 'visit'))
        .toSet();
  }
  return {};
}

bool isSidecarRule(ClassDeclaration node) {
  final superclassName = node.extendsClause?.superclass.name.name;
  final superclassUri =
      node.extendsClause?.superclass.type?.element?.librarySource?.uri;
  final isFromSidecarPackage = superclassUri?.path.contains('sidecar') ?? false;
  return superclassName == 'Rule' && isFromSidecarPackage;
}
