import 'package:freezed_annotation/freezed_annotation.dart';

import '../../analyzer/context/analyzed_file.dart';

part 'quick_assist_request.freezed.dart';

@freezed
class QuickAssistRequest with _$QuickAssistRequest {
  const factory QuickAssistRequest({
    required AnalyzedFile file,
    required int offset,
    required int length,
  }) = _FromPlugin;
}
