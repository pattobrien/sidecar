import 'package:glob/glob.dart';
import 'package:riverpod/riverpod.dart';

import '../../configurations/sidecar_spec/package_options.dart';
import '../../configurations/sidecar_spec/rule_options.dart';
import '../../configurations/sidecar_spec/sidecar_spec_base.dart';
import '../../protocol/models/rule_code.dart';
import 'active_package_provider.dart';

final projectSidecarSpecProvider = Provider<SidecarSpec>((ref) {
  final activePackage = ref.watch(activePackageProvider);
  return activePackage.sidecarSpec;
});

final activeProjectIncludeGlobsProvider = Provider<Set<Glob>>((ref) {
  final projectConfiguration = ref.watch(projectSidecarSpecProvider);
  return projectConfiguration.includes?.toSet() ?? SidecarSpec.defaultIncludes;
});

final activeProjectExcludeGlobsProvider = Provider<Set<Glob>>((ref) {
  final projectConfiguration = ref.watch(projectSidecarSpecProvider);
  return projectConfiguration.excludes?.toSet() ?? SidecarSpec.defaultExcludes;
});

final packageConfigurationForCodeProvider =
    Provider.family<PackageOptions?, RuleCode>((ref, code) {
  return ref.watch(projectSidecarSpecProvider.select(
      (sidecarSpec) => sidecarSpec.getPackageConfigurationForCode(code)));
});

final ruleConfigurationForCodeProvider =
    Provider.family<RuleOptions?, RuleCode>((ref, code) {
  return ref.watch(projectSidecarSpecProvider
      .select((sidecarSpec) => sidecarSpec.getConfigurationForCode(code)));
});
