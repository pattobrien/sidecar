import 'package:analyzer/dart/ast/ast.dart';
import 'package:meta/meta.dart';

import '../../rules/rules.dart';

/// A single subscription for a node type, by the specified [linter].
@internal
class VisitorSubscription<T> {
  VisitorSubscription(this.linter, this.visitor, this.timer);

  final LintRule linter;
  final AstVisitor visitor;
  final Stopwatch? timer;
}
