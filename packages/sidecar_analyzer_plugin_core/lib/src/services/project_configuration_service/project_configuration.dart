import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';

import '../log_delegate/log_delegate_base.dart';
import 'project_configuration_service.dart';

final projectConfigurationServiceProvider =
    Provider.family<ProjectConfigurationService, ContextRoot>(
  (ref, root) => ProjectConfigurationService(ref, contextRoot: root),
  dependencies: [logDelegateProvider],
);

final projectConfigurationProvider =
    FutureProvider.family<ProjectConfiguration?, ContextRoot>(
  (ref, contextRoot) async =>
      ref.watch(projectConfigurationServiceProvider(contextRoot)).parse(),
  dependencies: [projectConfigurationServiceProvider],
);

final projectConfigurationAnalysisErrorProvider =
    FutureProvider.family<Iterable<AnalysisError>, ContextRoot>(
  (ref, root) async {
    final yamlErrors = await ref.watch(projectConfigErrorProvider(root).future);
    return yamlErrors.map((yamlError) => yamlError.toAnalysisError());
  },
  dependencies: [projectConfigErrorProvider],
);

final projectConfigErrorProvider =
    FutureProvider.family<List<YamlSourceError>, ContextRoot>(
  (ref, root) async {
    final projectConfiguration =
        await ref.watch(projectConfigurationProvider(root).future);
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
  },
  dependencies: [projectConfigurationProvider],
);
