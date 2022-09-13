// ignore_for_file: implementation_imports

import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;

import 'package:analyzer/source/source_range.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/src/dart/ast/utilities.dart';
import 'package:analyzer/src/dart/ast/element_locator.dart';

import 'package:source_span/source_span.dart';

extension SourceSpanX on SourceSpan {
  plugin.Location get location => plugin.Location(
        sourceUrl!.path,
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
      end.offset +
          length, //TODO: is this correct?  or should it just be end.offset
    ).searchWithin(unit.unit);
  }

  Element? toElement(ResolvedUnitResult unit) {
    final node = NodeLocator(
      start.offset,
      end.offset +
          length, //TODO: is this correct?  or should it just be end.offset
    ).searchWithin(unit.unit);

    return ElementLocator.locate(node);
  }
}
