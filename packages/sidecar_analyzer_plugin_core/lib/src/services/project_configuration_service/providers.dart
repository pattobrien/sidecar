import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';

import '../../analysis_context_collection/enabled_contexts_provider.dart';
import '../log_delegate/log_delegate_base.dart';
import 'project_configuration_service.dart';

final projectConfigurationServicesProvider = FutureProvider(
  (ref) async {
    final roots = await ref.watch(enabledContextsProvider.future);
    return roots.map((context) =>
        ref.watch(projectConfigurationServiceProvider(context.contextRoot)));
  },
  dependencies: [
    enabledContextsProvider,
    projectConfigurationServiceProvider,
  ],
);

final projectConfigurationServiceProvider =
    Provider.family<ProjectConfigurationService, ContextRoot>(
  (ref, contextRoot) {
    return ProjectConfigurationService(ref, contextRoot: contextRoot);
  },
  dependencies: [logDelegateProvider],
);

final projectConfigurationProvider =
    FutureProvider.family<ProjectConfiguration?, ContextRoot>(
  (ref, contextRoot) async {
    await ref.watch(projectConfigurationServiceProvider(contextRoot)).parse();
    return ref
        .watch(projectConfigurationServiceProvider(contextRoot))
        .configuration;
  },
  dependencies: [projectConfigurationServiceProvider],
);

final projectConfigurationAnalysisErrorProvider =
    FutureProvider.family<Iterable<AnalysisError>, ContextRoot>(
  (ref, root) async {
    final yamlSourceErrors =
        await ref.watch(projectConfigurationErrorProvider(root).future);
    return yamlSourceErrors.map((e) => e.toAnalysisError());
  },
  dependencies: [projectConfigurationErrorProvider],
);

final projectConfigurationErrorProvider =
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
