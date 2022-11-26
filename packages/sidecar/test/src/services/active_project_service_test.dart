import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:package_config/package_config_types.dart';
import 'package:sidecar/src/services/active_project_service.dart';
import 'package:test/test.dart';

import '../../helpers/example_file_uris.dart';

void main() {
  final provider = PhysicalResourceProvider.INSTANCE;
  final activeProjectService = ActiveProjectService(resourceProvider: provider);
  group('sidecar package dependency:', () {
    test('valid config produces non-null uri', () {
      final config = PackageConfig([sidecarPackage, pathPackage]);
      expect(activeProjectService.getSidecarDependencyUri(config), isNotNull);
    });

    test('valid config produces absolute uri', () {
      final config = PackageConfig([sidecarPackage, pathPackage]);
      final package = activeProjectService.getSidecarDependencyUri(config);
      expect(package?.isAbsolute, isTrue);
    });

    test('invalid config produces null', () {
      final config = PackageConfig([pathPackage]);
      expect(activeProjectService.getSidecarDependencyUri(config), isNull);
    });
  });

  group('description', () {
    //
  });
}
