// ignore_for_file: implementation_imports

import 'package:analyzer/dart/analysis/results.dart' hide AnalysisResult;
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:analyzer/src/dart/ast/element_locator.dart';
import 'package:analyzer/src/dart/ast/utilities.dart';
import 'package:source_span/source_span.dart';

import '../models/models.dart';
import 'source_span_utilities.dart';

/// Used to translate a single AST node into a SourceSpan (i.e. start and end location within source code)
extension AstNodeX on AstNode {
  SourceRange toSourceRange(ResolvedUnitResult unit) {
    return toSourceSpan(unit).toSourceRange(); // SourceRange(offset, length);
  }

  SourceSpan toSourceSpan(ResolvedUnitResult unit) {
    // TODO: integrate endNode functionality here

    // final offset = !withCommentOrMetadata && node is AnnotatedNode
    //     ? node.firstTokenAfterCommentAndMetadata.offset
    //     : node.offset;
    // final end = endNode?.end ?? node.end;

    // final sourceUrl = Uri.file(unit.path);

    final startOffset = offset;
    final endOffset = end;

    final startLocation = unit.lineInfo.getLocation(startOffset);
    final endLocation = unit.lineInfo.getLocation(endOffset);

    return SourceSpan(
      SourceLocation(
        startOffset,
        sourceUrl: unit.path,
        column: startLocation.columnNumber,
        line: startLocation.lineNumber,
      ),
      SourceLocation(
        endOffset,
        sourceUrl: unit.path,
        column: endLocation.columnNumber,
        line: endLocation.lineNumber,
      ),
      unit.content.substring(startOffset, endOffset),
    );
  }

  Element? toElement(ResolvedUnitResult unit) {
    final node = NodeLocator(
      offset,
      end + length,
    ).searchWithin(unit.unit);

    return ElementLocator.locate(node);
  }

  AnalysisResult toAnalysisResult(
    SidecarBase rule, {
    required SourceSpan sourceSpan,
    required String message,
    String? correction,
    SourceSpan? highlightedSpan,
  }) =>
      AnalysisResult.generic(
        rule: rule,
        sourceSpan: sourceSpan,
        message: message,
        correction: correction,
        highlightedSpan: highlightedSpan,
      );

  DartAnalysisResult toDartAnalysisResult(
    SidecarBase rule, {
    required ResolvedUnitResult unit,
    required String message,
    String? correction,
    SourceSpan? highlightedSpan,
  }) =>
      AnalysisResult.dart(
        rule: rule,
        sourceSpan: toSourceSpan(unit),
        message: message,
        correction: correction,
        highlightedSpan: highlightedSpan,
      ) as DartAnalysisResult;

//   DetectedLint toDetectedLint(
//     ResolvedUnitResult unit,
//     SidecarBase rule, {
//     required DartAnalysisResult result,
//   }) =>
//       DetectedLint(
//         rule: rule,
//         unit: unit,
//         result: result,
//         lintType: rule.,
//         message: message,
//         correction: correction,
//       );
// }

// extension ListAstNodeX on List<AstNode> {
//   List<DetectedLint> toDetectedLints(
//     ResolvedUnitResult unit,
//     LintRule rule, {
//     String message = '',
//     String? correction,
//   }) {
//     return map((e) => e.toDetectedLint(unit, rule,
//         correction: correction, message: message)).toList();
//   }
}
