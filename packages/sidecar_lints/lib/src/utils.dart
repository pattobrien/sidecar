import 'package:analyzer/dart/ast/ast.dart';

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
  final superclassName = node.extendsClause?.superclass.name2.lexeme;
  final superclassUri =
      node.extendsClause?.superclass.type?.element?.librarySource?.uri;
  final isFromSidecarPackage = superclassUri?.path.contains('sidecar') ?? false;
  return (superclassName == 'LintRule' ||
          superclassName == 'DataRule' ||
          superclassName == 'AssistRule') &&
      isFromSidecarPackage;
}
