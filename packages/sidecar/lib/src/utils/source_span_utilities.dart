// ignore_for_file: implementation_imports

import 'package:analyzer/source/source_range.dart';
import 'package:source_span/source_span.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/src/dart/ast/utilities.dart';
import 'package:analyzer/src/dart/ast/element_locator.dart';

extension SourceSpanX on SourceSpan {
  plugin.Location get location => plugin.Location(
        start.sourceUrl!.path,
        start.offset,
        length,
        start.line,
        start.column,
        endLine: end.line,
        endColumn: end.column,
      );

  SourceRange toSourceRange() => SourceRange(start.offset, length);

  AstNode? toAstNode(ResolvedUnitResult unit) {
    return NodeLocator(
      start.offset,
      end.offset + length,
    ).searchWithin(unit.unit);
  }

  Element? toElement(ResolvedUnitResult unit) {
    final node = NodeLocator(
      start.offset,
      end.offset + length,
    ).searchWithin(unit.unit);

    return ElementLocator.locate(node);
  }

  static SourceSpan fromRawParameters(
    ResolvedUnitResult unit,
    int offset,
    int length,
  ) {
    final startOffset = offset;
    final endOffset = offset + length;

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
      // unit.content.substring(startOffset, endOffset),
      '',
    );
  }
}
