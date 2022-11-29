// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../src/rules/rules.dart';

export '../src/rules/base_rule.dart' hide BaseRule;
export '../src/rules/lint_severity.dart';

/// Base for all Sidecar Rules.
abstract class Rule extends GeneralizingAstVisitor<void> with BaseRule {
  @override
  @mustCallSuper
  void visitNode(AstNode node) {
    super.visitNode(node);
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is BaseRule &&
            const DeepCollectionEquality().equals(other.code, code));
  }

  @override
  int get hashCode => Object.hash(
        runtimeType,
        const DeepCollectionEquality().hash(code),
      );
}


// mixin Configuration on BaseRule {
//   Map<dynamic, dynamic>? get ruleConfiguration =>
//       sidecarSpec.getConfigurationForCode(code)?.configuration;
// }
