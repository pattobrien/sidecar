import 'package:glob/glob.dart';

import '../../models/lint_rule.dart';

String? ruleTypeToJson(LintRuleType? type) => type?.name;
LintRuleType? ruleTypeFromJson(String? type) =>
    type != null ? LintRuleTypeX.fromString(type) : null;

String globToJson(Glob glob) => glob.pattern;
List<String>? globsToJson(List<Glob>? globs) =>
    globs?.map((e) => e.pattern).toList();

Glob globFromJson(String glob) => Glob(glob);
List<Glob>? globsFromJson(List<String>? globs) => globs?.map(Glob.new).toList();
