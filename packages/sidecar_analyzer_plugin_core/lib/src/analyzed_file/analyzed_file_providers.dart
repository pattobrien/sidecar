// import 'package:riverpod/riverpod.dart';

// import '../plugin/analyzer/activated_rules_service.dart';
// import '../services/project_configuration_service/project_configuration.dart';
// import 'analyzed_file.dart';
// import 'analyzed_file_service.dart';

// final analyzedFileServiceProvider =
//     Provider.family<AnalyzedFileService, AnalyzedFile>(
//   (ref, file) {
//     final configuration =
//         ref.watch(projectConfigurationProvider(file.contextRoot));

//     return AnalyzedFileService(
//       ref,
//       activatedRules: ref.watch(activatedRulesProvider(file.contextRoot)),
//       projectConfiguration: configuration!,
//     );
//   },
//   dependencies: [
//     projectConfigurationProvider,
//     activatedRulesProvider,
//   ],
// );
