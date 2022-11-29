import 'package:meta/meta.dart';

import '../../../rules/rules.dart';

/// A single subscription for a node type, by the specified [visitor].
@internal
class VisitorSubscription<T> {
  /// A single subscription for a node type, by the specified [visitor].
  const VisitorSubscription(this.visitor, this.timer);

  /// BaseRule of the subscription.
  final Rule visitor;

  /// Timer to record how long it takes to run a given visit method.
  final Stopwatch? timer;
}
