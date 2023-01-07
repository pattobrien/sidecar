import 'package:freezed_annotation/freezed_annotation.dart';

import '../../protocol/analyzed_file.dart';
import '../../rules/base_rule.dart';

part 'rule_analyzed_file.freezed.dart';

@freezed
class RuleAnalyzedFile with _$RuleAnalyzedFile {
  const factory RuleAnalyzedFile({
    required BaseRule rule,
    required AnalyzedFile file,
  }) = _RuleAnalyzedFile;

  const RuleAnalyzedFile._();
}
