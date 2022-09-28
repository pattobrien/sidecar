import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../builder.dart';

part 'edit_result.freezed.dart';

@freezed
class EditResult with _$EditResult {
  const factory EditResult({
    required String message,
    required List<SourceFileEdit> sourceChanges,
  }) = _EditResult;
  const EditResult._();

  PrioritizedSourceChange toPrioritizedSourceChange() {
    return PrioritizedSourceChange(
        0,
        SourceChange(
          message,
          edits: sourceChanges,
        ));
  }
}
