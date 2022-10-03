// APPROVED ICONS

import 'package:flutter/material.dart';
import 'package:sidecar_annotations/sidecar_annotations.dart';

final x = '';

@SidecarInput(packageName: 'design_system_lints', configuration: {})
class ProjectIcons {
  static const abc = Icons.stop;
}

@designSystemIcons
class ProjectIcons2 {
  static const abc = Icons.party_mode;
}

final y = 1;

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

const designSystemIcons = DesignSystemIcons();
