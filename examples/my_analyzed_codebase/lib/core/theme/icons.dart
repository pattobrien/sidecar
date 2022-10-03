// APPROVED ICONS

import 'package:flutter/material.dart';
import 'package:sidecar_annotations/sidecar_annotations.dart';
import 'package:design_system_annotations/design_system_annotations.dart';

final x = '';

@SidecarInput(packageName: 'design_system_lints', configuration: {})
class ProjectIcons {
  static const abc = Icons.stop;
}

@designSystem
class ProjectIcons2 {
  static const abc = Icons.party_mode;
}

final y = 1;

@designSystemIcons
class ProjectIcons3 {
  static const abc = Icons.shield_outlined;
}
