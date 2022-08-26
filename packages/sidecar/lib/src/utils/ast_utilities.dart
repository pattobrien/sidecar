import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:source_span/source_span.dart';

/// Used to translate a single AST node into a SourceSpan (i.e. start and end location within source code)
extension AstNodeX on AstNode {
  SourceSpan toSourceSpan(ResolvedUnitResult source) {
    // TODO: integrate endNode functionality here

    // final offset = !withCommentOrMetadata && node is AnnotatedNode
    //     ? node.firstTokenAfterCommentAndMetadata.offset
    //     : node.offset;
    // final end = endNode?.end ?? node.end;

    final sourceUrl = Uri.file(source.path);

    final startOffset = offset;
    final endOffset = end;

    final startLocation = source.lineInfo.getLocation(startOffset);
    final endLocation = source.lineInfo.getLocation(endOffset);

    return SourceSpan(
      SourceLocation(
        startOffset,
        sourceUrl: sourceUrl,
        column: startLocation.columnNumber,
        line: startLocation.lineNumber,
      ),
      SourceLocation(
        endOffset,
        sourceUrl: sourceUrl,
        column: endLocation.columnNumber,
        line: endLocation.lineNumber,
      ),
      source.content.substring(startOffset, endOffset),
    );
  }
}
