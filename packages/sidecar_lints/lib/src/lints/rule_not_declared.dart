import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:collection/collection.dart';
import 'package:pubspec/pubspec.dart';
import 'package:recase/recase.dart';
import 'package:sidecar/sidecar.dart';
import 'package:yaml/yaml.dart';

import '../constants.dart';
import '../utils.dart';

class RuleNotDeclared extends Rule with Lint, QuickFix {
  static const _id = 'rule_not_declared';

  static const _message = 'Rule is not declared in Pubspec';
  static const _idMessage = 'Rule id does not match Rule class name.';
  static const _packageMessage =
      'Package id does not match package name from pubspec.yaml.';

  @override
  LintSeverity get defaultSeverity => LintSeverity.warning;

  @override
  LintCode get code => const LintCode(_id, package: kPackageName, url: kUri);

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
      reportAstNode(node.name, message: _message);
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
    if (snakeCaseName != idValueFromNode) {
      reportAstNode(id!, message: _idMessage);
    }

    final packageNodeValue = getStringValue(package);
    if (packageNodeValue != packageName) {
      reportAstNode(package!, message: _packageMessage);
    }
  }
}

String? getStringValue(AstNode? node) {
  if (node is SimpleIdentifier) {
    final dec = node.staticElement as PropertyAccessorElement?;
    final field = dec?.variable as FieldElement?;
    final val = field?.computeConstantValue();
    return val?.toStringValue();
  }
  if (node is StringLiteral) {
    return node.stringValue;
  }
  return null;
}

Set<String> getDeclaredLints(String pubspecContents) {
  final pubspec = PubSpec.fromYamlString(pubspecContents);
  final unparsedYaml = pubspec.unParsedYaml;
  final lints = unparsedYaml?['sidecar']['lints'] as YamlList?;
  return lints?.value.map((dynamic e) => e.toString()).toSet() ?? {};
}

Set<String> getDeclaredAssists(String pubspecContents) {
  final pubspec = PubSpec.fromYamlString(pubspecContents);
  final unparsedYaml = pubspec.unParsedYaml;
  final assists = unparsedYaml?['sidecar']['assists'] as YamlList?;
  return assists?.value.map((dynamic e) => e.toString()).toSet() ?? {};
}
