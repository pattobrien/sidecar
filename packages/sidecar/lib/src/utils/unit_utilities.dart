// ignore_for_file: implementation_imports

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/src/dart/ast/utilities.dart';

extension ResolvedUnitResultX on ResolvedUnitResult {
  AstNode? astNodeAt(int offset, {int length = 0}) {
    return NodeLocator(
      offset,
      offset + length,
    ).searchWithin(unit);
  }
}
