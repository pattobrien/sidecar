// ignore_for_file: public_member_api_docs

import 'package:analyzer/dart/element/type.dart';

import 'sidecar_type.dart';
import 'type_checker.dart';

extension InterfaceTypeX on InterfaceType {
  bool matchesType(SidecarType sidecarType) {
    final thisOrSupers = <InterfaceType>[this, ...allSupertypes];

    return thisOrSupers.any(
      (interfaceType) => TypeChecker.isMatch(
        interfaceType.element,
        type: sidecarType.type,
        sourcePath: sidecarType.sourcePath,
      ),
    );
  }
}
