import 'package:design_system_lints/design_system_lints.dart';
import 'package:sidecar/builder.dart';

List<SidecarBaseConstructor> main() {
  return [
    AvoidBorderRadiusLiteral.new,
    AvoidBoxShadowLiteral.new,
    AvoidColorLiteral.new,
    AvoidEdgeInsetsLiteral.new,
    AvoidIconLiteral.new,
  ];
}
