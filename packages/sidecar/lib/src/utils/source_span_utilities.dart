// ignore_for_file: implementation_imports

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:analyzer/src/dart/ast/element_locator.dart';
import 'package:analyzer/src/dart/ast/utilities.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;
import 'package:path/path.dart' as p;
import 'package:source_span/source_span.dart';

extension SourceSpanX on SourceSpan {
  plugin.Location get location {
    final url = sourceUrl;
    if (url == null) {
      throw UnimplementedError(
          'SourceSpanX extension expects the source url to be non-null.');
    } else {
      final fileExt = p.extension(url.path);
      final isYaml = fileExt == '.yaml' || fileExt == '.yml';
      return plugin.Location(
        url.path,
        start.offset,
        length,
        isYaml ? start.line + 1 : start.line,
        isYaml ? start.column + 1 : start.column,
        endLine: isYaml ? end.line + 1 : end.line,
        endColumn: isYaml ? end.column + 1 : end.column,
      );
    }
  }

  SourceRange toSourceRange() => SourceRange(start.offset, length);

  AstNode? toAstNode(ResolvedUnitResult unit) {
    return NodeLocator(
      start.offset,
      end.offset,
    ).searchWithin(unit.unit);
  }

  Element? toElement(ResolvedUnitResult unit) {
    final node = NodeLocator(
      start.offset,
      end.offset,
    ).searchWithin(unit.unit);

    return ElementLocator.locate(node);
  }
}
