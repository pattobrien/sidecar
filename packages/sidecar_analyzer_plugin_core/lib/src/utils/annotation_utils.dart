import 'package:analyzer/dart/element/type.dart';
import 'package:sidecar/sidecar.dart';

class SidecarTypeChecker {
  const SidecarTypeChecker._();

  static bool isSidecarInput(InterfaceType? type) {
    return TypeChecker.isThisOrSuperTypeMatch(
      type,
      type: 'SidecarInput',
      sourcePath: 'sidecar_annotations/src/sidecar_annotations_base.dart',
    );
  }
}
