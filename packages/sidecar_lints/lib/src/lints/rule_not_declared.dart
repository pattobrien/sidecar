import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:collection/collection.dart';
import 'package:pubspec/pubspec.dart';
import 'package:recase/recase.dart';
import 'package:sidecar/sidecar.dart';
import 'package:yaml/yaml.dart';

import '../constants.dart';
import '../utils.dart';

class RuleNotDeclared extends LintRule with QuickFix {
  static const id = 'rule_not_declared';

  static const _message = 'Rule is not declared in Pubspec';
  static const _idMessage = 'Rule id does not match Rule class name.';
  static const _packageMessage = 'Package id does not match package name.';

  @override
  LintSeverity get defaultSeverity => LintSeverity.warning;

  @override
  LintCode get code => const LintCode(id, package: kPackageName, url: kUri);

  @override
  void initializeVisitor(NodeRegistry registry) {
    registry.addClassDeclaration(this);
  }

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    if (!isSidecarRule(node)) return;
    final context = unit.session.analysisContext;
    final pubspecContents = context.contextRoot.root
        .getChildAssumingFile('pubspec.yaml')
        .readAsStringSync();

    final pubspec = PubSpec.fromYamlString(pubspecContents);
    final packageName = pubspec.name;
    final lints = getDeclaredLints(pubspecContents);
    final snakeCaseName = ReCase(node.name.name).snakeCase;
    if (!lints.contains(snakeCaseName)) {
      reportLint(node.name, message: _message);
    }

    final code = node.members
        .whereType<MethodDeclaration>()
        .firstWhere((element) => element.name.name == 'code');

    final lintCode = code.body.childEntities.firstWhereOrNull((element) {
      if (element is! InstanceCreationExpression) return false;
      return element.staticType?.name == 'LintCode';
    }) as InstanceCreationExpression?;

    final codeArguments = lintCode?.argumentList.arguments;
    final id = codeArguments?.firstWhereOrNull((e) => e is! NamedExpression);
    final package = codeArguments
        ?.whereType<NamedExpression>()
        .firstWhereOrNull((e) => e.name.label.name == 'package')
        ?.expression;

    final idValueFromNode = getStringValue(id);
    if (snakeCaseName != idValueFromNode && id != null) {
      reportLint(id, message: _idMessage);
    }

    final packageNodeValue = getStringValue(package);
    if (packageNodeValue != packageName && package != null) {
      reportLint(package, message: _packageMessage);
    }
  }
}

String? getStringValue(Expression? node) {
  if (node is SimpleIdentifier) {
    final element = node.staticElement;
    if (element is PropertyAccessorElement) {
      final variable = element.variable;
      final object = variable.computeConstantValue();
      return object?.toStringValue();
    }
  }
  if (node is StringLiteral) {
    return node.stringValue;
  }
  return null;
}

Set<String> getDeclaredLints(String pubspecContents) {
  final pubspec = PubSpec.fromYamlString(pubspecContents);
  final unparsedYaml = pubspec.unParsedYaml;
  final dynamic lints = unparsedYaml?['sidecar']['lints'];
  if (lints is! YamlList?) return {};
  return lints?.value.map((dynamic e) => e.toString()).toSet() ?? {};
}

Set<String> getDeclaredAssists(String pubspecContents) {
  final pubspec = PubSpec.fromYamlString(pubspecContents);
  final unparsedYaml = pubspec.unParsedYaml;
  final dynamic assists = unparsedYaml?['sidecar']['assists'];
  if (assists is! YamlList?) return {};
  return assists?.value.map((dynamic e) => e.toString()).toSet() ?? {};
}
