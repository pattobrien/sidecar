// import 'dart:async';

// import 'package:riverpod/riverpod.dart';
// import 'package:path/path.dart' as p;

// import '../../utils/utils.dart';
// import 'analyzer_resource_provider.dart';


// // final rootUriProvider = Provider<Uri>((ref) => Uri());


// StreamSubscription? _listenToConfigForChanges(
//   Ref ref,
//   Uri context,
// ) {
//   final path = p.join(context.root.path, kSidecarYaml);
//   final resourceProvider = ref.watch(analyzerResourceProvider);
//   final file = resourceProvider.getFile(path);
//   if (!file.exists) return null;
//   final resourceWatcher = file.watch();
//   return resourceWatcher.changes.listen((event) {
//     // if (event.type != ChangeType.REMOVE) {
//     ref.read(activeContextNotifierProvider.notifier).updateConfig();
//     final activeContext = ref.read(activeContextNotifierProvider);

//     // ref.invalidate(analysisContextForRootProvider);
//     // ref.invalidate(activeContextsProvider);
//     ref.invalidate(filteredRulesForFileProvider);
//     ref.invalidate(activatedRulesForRootProvider);
//     for (final file in activeContext.context.typedAnalyzedFiles()) {
//       ref.invalidate(analysisResultsForFileProvider(file));
//       ref.refresh(createAnalysisReportProvider(file).future);
//       // ref.read(createAnalysisReportProvider(file).future);
//       // ref.read(analysisResultsForFileProvider(file).future);
//       // ref.read(createAnalysisReportProvider(file));
//     }
//     // }
//   });
// }
