import 'package:riverpod/riverpod.dart';

import '../../rules/rules.dart';

/// Provides list of rules enabled for the context
final ruleConstructorProvider = Provider<List<SidecarBaseConstructor>>(
  (ref) => throw UnimplementedError(),
  name: 'ruleConstructorProvider',
  dependencies: const [],
);
