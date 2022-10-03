import 'package:sidecar_annotations/sidecar_annotations.dart';

const _packageName = 'design_system_lints';

class DesignSystem extends SidecarInput {
  const DesignSystem()
      : super(
          packageName: _packageName,
          configuration: const {},
        );
}

class DesignSystemIcons extends SidecarInput {
  const DesignSystemIcons()
      : super(
          packageName: _packageName,
          configuration: const {},
        );
}

const designSystemIcons = DesignSystemIcons();
const designSystem = DesignSystem();
