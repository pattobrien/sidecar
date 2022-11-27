import 'package:analyzer/dart/ast/ast.dart';

extension AstNodeEqualityX on AstNode {
  bool isSameAs(AstNode other) {
    return other.toSource() == toSource() &&
        other.offset == offset &&
        other.end == end;
  }
}
