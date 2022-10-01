import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';

import 'project_configuration_service.dart';

final projectConfigurationServiceProvider =
    Provider.family<ProjectConfigurationService, ContextRoot>(
  (ref, contextRoot) {
    return ProjectConfigurationService(ref, contextRoot: contextRoot);
  },
);

final projectConfigurationProvider =
    Provider.family<ProjectConfiguration?, ContextRoot>(
  (ref, contextRoot) {
    return ref
        .watch(projectConfigurationServiceProvider(contextRoot))
        .configuration;
  },
);

final projectConfigurationErrorProvider =
    Provider.family<List<YamlSourceError>, ContextRoot>((ref, root) {
  final projectConfiguration = ref.watch(projectConfigurationProvider(root));
  return <YamlSourceError>[
    ...?projectConfiguration?.sourceErrors,
    ...projectConfiguration?.assistPackages?.values
            .map((e) => e.sourceErrors)
            .expand((element) => element)
            .toList() ??
        [],
    ...projectConfiguration?.lintPackages?.values
            .map((e) => e.sourceErrors)
            .expand((element) => element)
            .toList() ??
        [],
    ...projectConfiguration?.lintPackages?.values
            .map((e) => e.lints)
            .map((e) => e.values)
            .expand((element) => element)
            .map((e) => e.sourceErrors)
            .expand((element) => element)
            .toList() ??
        [],
    ...projectConfiguration?.assistPackages?.values
            .map((e) => e.assists)
            .map((e) => e.values)
            .expand((element) => element)
            .map((e) => e.sourceErrors)
            .expand((element) => element)
            .toList() ??
        [],
  ];
});
