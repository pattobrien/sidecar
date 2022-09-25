import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';

final lintRuleConstructorProvider = Provider<Map<Id, LintRuleConstructor>>(
  (ref) => throw UnimplementedError(),
);

final codeEditConstructorProvider = Provider<Map<Id, CodeEditConstructor>>(
  (ref) => throw UnimplementedError(),
);
