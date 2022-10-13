import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';

import '../../plugin/middleman/analysis_context_providers.dart';
import '../log_delegate/log_delegate_base.dart';
import 'project_configuration_service.dart';

final projectConfigurationProvider =
    Provider.family<ProjectConfiguration?, ContextRoot>(
  (ref, contextRoot) {
    final projectConfigurationService = ProjectConfigurationService(ref);
    return projectConfigurationService.parse(contextRoot);
  },
  dependencies: [logDelegateProvider],
);

final projectConfigurationAnalysisErrorProvider =
    Provider.family<Iterable<AnalysisError>, ContextRoot>(
  (ref, root) {
    final yamlErrors = ref.watch(projectConfigErrorProvider(root));
    return yamlErrors.map((yamlError) => yamlError.toAnalysisError());
  },
  dependencies: [projectConfigErrorProvider],
);

final projectConfigErrorProvider =
    Provider.family<List<YamlSourceError>, ContextRoot>(
  (ref, root) {
    final projectConfiguration = ref.watch(projectConfigurationProvider(root));
    return <YamlSourceError>[
      ...?projectConfiguration?.sourceErrors,
      ...?projectConfiguration?.assistPackages?.values
          .map((e) => e.sourceErrors)
          .expand((element) => element),
      ...?projectConfiguration?.lintPackages?.values
          .map((e) => e.sourceErrors)
          .expand((element) => element),
      ...?projectConfiguration?.lintPackages?.values
          .map((e) => e.lints)
          .map((e) => e.values)
          .expand((element) => element)
          .map((e) => e.sourceErrors)
          .expand((element) => element),
      ...?projectConfiguration?.assistPackages?.values
          .map((e) => e.assists)
          .map((e) => e.values)
          .expand((element) => element)
          .map((e) => e.sourceErrors)
          .expand((element) => element),
    ];
  },
  dependencies: [projectConfigurationProvider],
);
