import 'package:meta/meta.dart';

import '../../../rules/rules.dart';

/// A single subscription for a node type, by the specified [rule].
@internal
class VisitorSubscription<T> {
  VisitorSubscription(this.visitor, this.timer);

  // @Deprecated('message')
  // final LintMixin rule;
  final SidecarAstVisitor visitor;
  final Stopwatch? timer;
}
