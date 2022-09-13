// ignore_for_file: implementation_imports

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/source/line_info.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:source_span/source_span.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/src/dart/ast/utilities.dart';
import 'package:analyzer/src/dart/ast/element_locator.dart';

import '../../sidecar.dart';

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
}

extension ListAstNodeX on List<AstNode> {
  List<DetectedLint> toDetectedLints(ResolvedUnitResult unit, LintRule rule) {
    return map((e) => DetectedLint(
        rule: rule, unit: unit, sourceSpan: e.toSourceSpan(unit))).toList();
  }
}
