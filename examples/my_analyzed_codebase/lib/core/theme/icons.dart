// APPROVED ICONS

import 'package:flutter/material.dart';
import 'package:sidecar_annotations/sidecar_annotations.dart';

// @designSystemIcons
// @designSystemIcons2
final x = '';

@SidecarInput(packageName: 'design_system_lints', configuration: {})
class ProjectIcons {
  static const abc = Icons.stop;
}

// @designSystemIcons2
class ProjectIcons2 {
  static const abc = Icons.party_mode;
}

class ProjectIcons3 {
  static const abc = Icons.shield_outlined;
}

class DesignSystemIcons extends SidecarInput {
  const DesignSystemIcons()
      : super(
          packageName: 'design_system_lints',
          configuration: const {},
        );
}

class DesignSystemIcons2 implements SidecarInput {
  const DesignSystemIcons2();
  @override
  Map get configuration => {};

  @override
  String? get lintName => null;

  @override
  String get packageName => 'design_system_lints';
}

const designSystemIcons = DesignSystemIcons();
const designSystemIcons2 = DesignSystemIcons2();
