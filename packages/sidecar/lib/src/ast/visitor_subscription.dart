import 'package:analyzer/dart/ast/ast.dart';
import 'package:meta/meta.dart';

import '../models/lint_rule.dart';

/// A single subscription for a node type, by the specified [linter].
@internal
class VisitorSubscription<T> {
  final LintRule linter;
  final AstVisitor visitor;
  final Stopwatch? timer;

  VisitorSubscription(this.linter, this.visitor, this.timer);
}
