import '../src/rules/rules.dart';

mixin Configuration on BaseRule {
  Map<dynamic, dynamic>? get ruleConfiguration =>
      sidecarSpec.getConfigurationForCode(code)?.configuration;
}
