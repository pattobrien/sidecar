import 'package:analyzer/dart/ast/ast.dart';
import 'package:meta/meta.dart';

import '../../rules/rules.dart';

/// A single subscription for a node type, by the specified [rule].
@internal
class VisitorSubscription<T> {
  VisitorSubscription(this.rule, this.visitor, this.timer);

  final LintRule rule;
  final SidecarVisitor visitor;
  final Stopwatch? timer;
}
