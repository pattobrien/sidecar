import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:sidecar/sidecar.dart';

class SidecarTypeChecker {
  static bool isSidecarInput(Element? element) {
    return TypeChecker.isThisOrSuperMatch(
      element,
      type: 'SidecarInput',
      sourcePath: 'sidecar_annotations/src/sidecar_annotations_base.dart',
    );
  }
}
