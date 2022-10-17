import 'package:build/build.dart';
import 'package:sidecar_generator/src/package_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder packageConfigurationBuilder(BuilderOptions options) =>
    SharedPartBuilder(
        [SidecarPackageGenerator()], 'package_configuration_generator');
