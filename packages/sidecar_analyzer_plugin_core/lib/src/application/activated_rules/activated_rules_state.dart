import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sidecar/builder.dart';

part 'activated_rules_state.freezed.dart';

@freezed
class ActivatedRulesState with _$ActivatedRulesState {
  const ActivatedRulesState._();
  const factory ActivatedRulesState({
    @Default([]) List<SidecarBase> rules,
  }) = _ActivatedRulesState;
}
