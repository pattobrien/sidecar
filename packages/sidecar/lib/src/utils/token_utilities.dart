import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:source_span/source_span.dart';

import 'source_span_utilities.dart';

/// Used to translate a single token into a SourceSpan (i.e. start and end location within source code)
extension TokenX on Token {
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
}
