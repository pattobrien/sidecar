// ignore_for_file: implementation_imports

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:analyzer/src/dart/ast/element_locator.dart';
import 'package:analyzer/src/dart/ast/utilities.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;
import 'package:source_span/source_span.dart';

import '../models/detected_lint.dart';
import '../models/lint_rule.dart';

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

  plugin.Location get yamlLocation => plugin.Location(
        sourceUrl!.path,
        start.offset,
        length,
        start.line + 1,
        start.column + 1,
        endLine: end.line + 1,
        endColumn: end.column + 1,
      );

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

  // DetectedLint toDetectedLint(ResolvedUnitResult unit, LintRule rule) {
  //   return DetectedLint(rule: rule, unit: unit, sourceSpan: this);
  // }
}

// extension ListSourceSpanX on List<SourceSpan> {
//   List<DetectedLint> toDetectedLints(ResolvedUnitResult unit, LintRule rule) {
//     return map((e) => e.toDetectedLint(unit, rule)).toList();
//   }
// }
