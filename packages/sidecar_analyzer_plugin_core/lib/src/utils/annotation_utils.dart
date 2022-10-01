import 'package:analyzer/dart/element/type.dart';
import 'package:sidecar/sidecar.dart';

class SidecarTypeChecker {
  static bool isSidecarInput(DartType? interfaceType) {
    return TypeChecker.isThisOrSuperTypeMatch(
      interfaceType as InterfaceType,
      type: 'SidecarInput',
      sourcePath: 'sidecar_annotations/src/sidecar_annotations_base.dart',
    );
  }
}
