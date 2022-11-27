export 'mixins.dart';
export '../src/rules/lint_severity.dart';
export '../src/rules/base_rule.dart' hide BaseRule;
export '../src/rules/typedefs.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../src/rules/rules.dart';

abstract class SidecarAstVisitor extends GeneralizingAstVisitor<void>
    with BaseRule {
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
