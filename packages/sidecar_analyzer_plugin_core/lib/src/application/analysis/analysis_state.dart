// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:sidecar/sidecar.dart';

// import '../../context_services/analysis_errors.dart';

// part 'analysis_state.freezed.dart';

// @freezed
// class AnalysisState with _$AnalysisState {
//   const AnalysisState._();
//   const factory AnalysisState({
//     required AnalyzedFile analyzedFile,
//     @Default([]) List<AnalysisResult> results,
//   }) = _AnalysisState;

//   String get path => analyzedFile.path;

//   List<AnalysisResult> get sortedResults => results
//     ..sort((a, b) => a.sourceSpan.location.startLine
//         .compareTo(b.sourceSpan.location.startLine));
// }
