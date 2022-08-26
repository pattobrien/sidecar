import 'package:analyzer/dart/ast/ast.dart';
import 'package:meta/meta.dart';

import '../models/lint_error.dart';

/// A single subscription for a node type, by the specified [linter].
@internal
class VisitorSubscription<T> {
  final LintError linter;
  final AstVisitor visitor;
  final Stopwatch? timer;

  VisitorSubscription(this.linter, this.visitor, this.timer);
}
