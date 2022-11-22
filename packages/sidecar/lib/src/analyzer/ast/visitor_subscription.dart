import 'package:analyzer/dart/ast/ast.dart';
import 'package:meta/meta.dart';
import 'package:sidecar/src/rules/all_rules.dart';

import '../../../rules/rules.dart';
import '../../rules/rules.dart';

/// A single subscription for a node type, by the specified [rule].
@internal
class VisitorSubscription<T> {
  VisitorSubscription(this.visitor, this.timer);

  // @Deprecated('message')
  // final LintMixin rule;
  final SidecarVisitor visitor;
  final Stopwatch? timer;
}
