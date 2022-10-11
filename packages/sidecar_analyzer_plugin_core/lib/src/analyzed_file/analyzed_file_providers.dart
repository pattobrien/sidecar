import 'package:riverpod/riverpod.dart';

import '../analysis_context/resolved_unit_service.dart';
import '../analysis_context_collection/analysis_context_collection.dart';
import '../application/rules/activated_rules_service.dart';
import '../services/project_configuration_service/providers.dart';
import 'analyzed_file.dart';
import 'analyzed_file_service.dart';

final analyzedFileServiceProvider =
    FutureProvider.family<AnalyzedFileService, AnalyzedFile>(
  (ref, analyzedFile) async {
    final context =
        await ref.watch(enabledContextProvider(analyzedFile).future);
    final unitResults =
        await ref.watch(resolvedUnitContextProvider(context).future);
    final configuration = await ref
        .watch(projectConfigurationProvider(analyzedFile.contextRoot).future);
    final activatedRules = await ref
        .watch(activatedRulesProvider(analyzedFile.contextRoot).future);
    return AnalyzedFileService(
      ref,
      context: context,
      unitResult: unitResults[analyzedFile],
      activatedRules: activatedRules,
      projectConfiguration: configuration!,
    );
  },
  dependencies: [
    enabledContextProvider,
    resolvedUnitContextProvider,
    projectConfigurationProvider,
    activatedRulesProvider,
  ],
);
