import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:glob/glob.dart';

import '../protocol/protocol.dart';

abstract class BaseRule {
  RuleCode get code;
  List<Glob>? get includes => null;
  List<Glob>? get excludes => null;
}

mixin Configuration on BaseRule {
  late final Map<dynamic, dynamic>? packageConfiguration;
  late final Map<dynamic, dynamic>? ruleConfiguration;

  @internal
  void init({
    Map<dynamic, dynamic>? packageConfiguration,
    Map<dynamic, dynamic>? ruleConfiguration,
  }) {
    this.packageConfiguration = packageConfiguration;
    this.ruleConfiguration = ruleConfiguration;
  }
}
