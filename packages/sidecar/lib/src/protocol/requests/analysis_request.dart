import 'package:freezed_annotation/freezed_annotation.dart';

part 'analysis_request.freezed.dart';

@freezed
class AnalysisRequest with _$AnalysisRequest {
  const factory AnalysisRequest({
    required String path,
  }) = _AnalysisRequest;
  const AnalysisRequest._();
}
