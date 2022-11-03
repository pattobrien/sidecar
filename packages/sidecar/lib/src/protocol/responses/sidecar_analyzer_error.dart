import 'package:freezed_annotation/freezed_annotation.dart';

part 'sidecar_analyzer_error.freezed.dart';

@freezed
class SidecarAnalyzerError with _$SidecarAnalyzerError {
  const factory SidecarAnalyzerError(
    Object? error,
    StackTrace? stackTrace,
  ) = _SidecarAnalyzerError;
  const SidecarAnalyzerError._();

  factory SidecarAnalyzerError.fromJson(Map<String, dynamic> json) {
    return SidecarAnalyzerError(
      json['error'],
      StackTrace.fromString(json['stackTrace'] as String),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'error': error.toString(),
        'stackTrace': stackTrace.toString(),
      };
}
