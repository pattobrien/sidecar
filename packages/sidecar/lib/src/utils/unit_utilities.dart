import 'package:analyzer/src/dart/ast/utilities.dart';

import '../../sidecar.dart';

extension ResolvedUnitResultX on ResolvedUnitResult {
  AstNode? astNodeAt(int offset, {int length = 0}) {
    return NodeLocator(
      offset,
      offset + length,
    ).searchWithin(unit);
  }
}
