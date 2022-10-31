import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_result.freezed.dart';

@freezed
class EditResult with _$EditResult {
  const factory EditResult({
    required String message,
    required List<SourceFileEdit> sourceChanges,
  }) = _EditResult;
  const EditResult._();
}

extension EditResultX on EditResult {
  PrioritizedSourceChange toPrioritizedSourceChange() {
    return PrioritizedSourceChange(
      0,
      SourceChange(message, edits: sourceChanges),
    );
  }
}
