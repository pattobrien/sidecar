import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:riverpod/riverpod.dart';

import '../../sidecar.dart';

part 'detected_lint.freezed.dart';

/// An instance of a detected lint, to be reported to the analyzer server.
// class DetectedLint {
//   const DetectedLint({
//     required this.rule,
//     required this.unit,
//     required this.sourceSpan,
//     this.message = '',
//   }) {
//     lintType = rule.defaultType;
//   }

//   factory DetectedLint.fromAstNode(
//     AstNode node,
//     ResolvedUnitResult unit,
//     LintRule rule, {
//     String message = '',
//   }) {
//     return DetectedLint(
//       rule: rule,
//       unit: unit,
//       message: message,
//       sourceSpan: node.toSourceSpan(unit),
//     );
//   }

// final LintRule rule;

// final String message;

// late LintRuleType lintType;

// /// Source of the source Ast Node
// final ResolvedUnitResult unit;

// final SourceSpan sourceSpan;

//   DetectedLint copyWith({
//     SourceSpan? sourceSpan,
//   }) =>
//       DetectedLint(
//         rule: rule,
//         message: message,
//         unit: unit,
//         sourceSpan: sourceSpan ?? this.sourceSpan,
//         lintType: lintType,
//       );

// Future<plugin.AnalysisErrorFixes> toAnalysisErrorFixes(
//   ProviderContainer ref,
// ) async {
//   final fixes = await rule.computeCodeEdits(this);
//   return plugin.AnalysisErrorFixes(
//     toAnalysisError()..hasFix = fixes.isNotEmpty,
//     fixes: fixes,
//   );
// }

// plugin.AnalysisError toAnalysisError() {
//   return plugin.AnalysisError(
//     rule.defaultType.analysisError,
//     plugin.AnalysisErrorType.HINT,
//     sourceSpan.location,
//     rule.message,
//     rule.code,
//     url: rule.url,
//   );
// }
// }

@freezed
class DetectedLint with _$DetectedLint {
  const factory DetectedLint({
    required LintRule rule,
    required String message,
    required LintRuleType lintType,
    required ResolvedUnitResult unit,
    required SourceSpan sourceSpan,
    String? correction,
  }) = _DetectedLint;

  const DetectedLint._();

  Future<plugin.AnalysisErrorFixes> toAnalysisErrorFixes(
    ProviderContainer ref,
  ) async {
    final fixes = await rule.computeCodeEdits(this);
    return plugin.AnalysisErrorFixes(
      toAnalysisError()..hasFix = fixes.isNotEmpty,
      fixes: fixes,
    );
  }

  plugin.AnalysisError toAnalysisError() {
    final concatLintCode = '${rule.packageName}.${rule.code}';
    return plugin.AnalysisError(
      lintType.analysisError,
      plugin.AnalysisErrorType.HINT,
      sourceSpan.location,
      message,
      concatLintCode,
      url: rule.url,
      correction: correction,
      //TODO: hasFix
    );
  }
}
