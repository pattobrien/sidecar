import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:analyzer/dart/element/element.dart';

extension AstNodeEqualityX on AstNode {
  bool isSameAs(AstNode other) {
    return other.toSource() == toSource() &&
        other.offset == offset &&
        other.end == end;
  }
}

extension ElementX on Element {}
