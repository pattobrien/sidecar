import 'package:riverpod/riverpod.dart';

import '../analysis_context/resolved_unit_service.dart';
import '../analysis_context_collection/analysis_context_collection.dart';
import '../application/rules/activated_rules_service.dart';
import '../services/project_configuration_service/project_configuration.dart';
import 'analyzed_file.dart';
import 'analyzed_file_service.dart';

final analyzedFileServiceProvider =
    FutureProvider.family<AnalyzedFileService, AnalyzedFile>(
  (ref, file) async {
    final context = await ref.watch(enabledContextProvider(file).future);

    final unitResult = await ref
        .watch(resolvedUnitServiceProvider(context))
        .getResolvedUnit(file);

    final configuration =
        await ref.watch(projectConfigurationProvider(file.contextRoot).future);

    final activatedRules =
        await ref.watch(activatedRulesProvider(file.contextRoot).future);

    return AnalyzedFileService(
      ref,
      context: context,
      unitResult: unitResult,
      activatedRules: activatedRules,
      projectConfiguration: configuration!,
    );
  },
  dependencies: [
    resolvedUnitServiceProvider,
    enabledContextProvider,
    projectConfigurationProvider,
    activatedRulesProvider,
  ],
);
