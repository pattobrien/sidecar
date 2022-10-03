import 'package:freezed_annotation/freezed_annotation.dart';

part 'annotation_result.freezed.dart';

@freezed
class AnnotationResult with _$AnnotationResult {
  const factory AnnotationResult({
    required String packageName,
    String? analysisRuleId,
    String? annotationId,
  }) = _AnnotationResult;
  const AnnotationResult._();
}
