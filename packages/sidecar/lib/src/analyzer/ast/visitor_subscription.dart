import 'package:meta/meta.dart';

import '../../../rules/rules.dart';

/// A single subscription for a node type, by the specified [rule].
@internal
class VisitorSubscription<T> {
  /// A single subscription for a node type, by the specified [rule].
  const VisitorSubscription(this.rule, this.timer);

  /// BaseRule of the subscription.
  final Rule rule;

  /// Timer to record how long it takes to run a given visit method.
  final Stopwatch? timer;
}
