import 'package:analyzer/dart/ast/ast.dart';
import 'package:collection/collection.dart';
import 'package:sidecar/sidecar.dart';

import 'constants.dart';

class MissingVisitMethodRegistration extends Rule with Lint {
  static const _id = 'missing_visit_method_registration';
  static const _message = 'Visit method is not added to registry';
  static const _correction =
      'Initialize via NodeRegistry in initializeVisitor method';

  @override
  LintCode get code => const LintCode(_id, package: kPackageName, url: kUri);

  @override
  void initializeVisitor(NodeRegistry registry) {
    registry.addClassDeclaration(this);
  }

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    if (!isSidecarRule(node)) return;

    final properties = node.members.whereType<MethodDeclaration>();

    final initializerMethod = properties.firstWhereOrNull(
        (element) => element.name.name == 'initializeVisitor');

    final visitMethods = properties
        .where((element) => element.name.name.contains('visit'))
        .map((e) => e.name.name)
        .toSet();

    final initializerBody = initializerMethod?.body;

    if (initializerBody is BlockFunctionBody) {
      final statements = initializerBody.block.statements;

      // ReturnStatement or ExpressionStatement
      for (final statement in statements) {
        if (statement is ExpressionStatement) {
          final methodNames = getVisitMethodNames(statement.expression);
          visitMethods.removeAll(methodNames);
        }

        if (statement is ReturnStatement && statement.expression != null) {
          final methodNames = getVisitMethodNames(statement.expression!);
          visitMethods.removeAll(methodNames);
        }
      }
    }

    if (initializerBody is ExpressionFunctionBody) {
      final methodNames = getVisitMethodNames(initializerBody.expression);
      visitMethods.removeAll(methodNames);
    }

    if (visitMethods.isEmpty) return;

    for (final methodName in visitMethods) {
      final method =
          properties.firstWhere((element) => element.name.name == methodName);
      reportAstNode(method.name, message: _message, correction: _correction);
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
