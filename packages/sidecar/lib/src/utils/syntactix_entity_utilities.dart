// ignore_for_file: implementation_imports

import 'package:analyzer/dart/analysis/results.dart' hide AnalysisResult;
import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:analyzer/src/dart/ast/element_locator.dart';
import 'package:analyzer/src/dart/ast/utilities.dart';
import 'package:source_span/source_span.dart';

import 'source_span_utilities.dart';

/// Used to translate a single AST node into a SourceSpan (i.e. start and end location within source code)
extension SyntacticEntityX on SyntacticEntity {
  SourceRange toSourceRange(ResolvedUnitResult unit) {
    return toSourceSpan(unit).toSourceRange();
  }

  SourceSpan toSourceSpan(ResolvedUnitResult unit) {
    final startOffset = offset;
    final endOffset = end;

    final startLocation = unit.lineInfo.getLocation(startOffset);
    final endLocation = unit.lineInfo.getLocation(endOffset);

    final sourceSpan = SourceSpan(
      SourceLocation(
        startOffset,
        sourceUrl: Uri.file(unit.path),
        column: startLocation.columnNumber,
        line: startLocation.lineNumber,
      ),
      SourceLocation(
        endOffset,
        sourceUrl: Uri.file(unit.path),
        column: endLocation.columnNumber,
        line: endLocation.lineNumber,
      ),
      unit.content.substring(startOffset, endOffset),
    );
    return sourceSpan;
  }

  SourceSpan toSourceSpanFromPath(String path, String source) {
    // TODO: integrate endNode functionality here

    // final offset = !withCommentOrMetadata && node is AnnotatedNode
    //     ? node.firstTokenAfterCommentAndMetadata.offset
    //     : node.offset;
    // final end = endNode?.end ?? node.end;

    final startOffset = offset;
    final endOffset = end;

    return SourceSpan(
      SourceLocation(
        startOffset,
        sourceUrl: path,
        // column: startLocation.columnNumber,
        // line: startLocation.lineNumber,
      ),
      SourceLocation(
        endOffset,
        sourceUrl: path,
        // column: endLocation.columnNumber,
        // line: endLocation.lineNumber,
      ),
      source,
    );
  }

  Element? toElement(ResolvedUnitResult unit) {
    final node = NodeLocator(
      offset,
      end + length,
    ).searchWithin(unit.unit);

    return ElementLocator.locate(node);
  }
}
