import 'dart:async';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:riverpod/riverpod.dart';

import '../../utils/logger/logger.dart';
import '../context/context.dart';
import '../plugin/plugin.dart';

final resolvedUnitProvider =
    FutureProvider.family<ResolvedUnitResult?, AnalyzedFile>(
  (ref, file) async {
    SomeResolvedUnitResult? someUnitResult;
    await report(() async {
      final context = ref.watch(activeContextForRootProvider(file.root));
      final analysisSession = context.currentSession;
      someUnitResult = await analysisSession.getResolvedUnit(file.path);
    }, 'resolvedUnitProvider');
    final r = someUnitResult is ResolvedUnitResult ? someUnitResult : null;
    return r as ResolvedUnitResult?;
  },
  name: 'resolvedUnitProvider',
  dependencies: [
    activeContextForRootProvider,
  ],
);

Future<void> report(
  Future<void> Function() b,
  String message,
) async {
  final watch = Stopwatch()..start();
  logger.info(message);
  await b();
  final countS = '${watch.elapsed.inSeconds.remainder(60)}';
  final countMs =
      watch.elapsed.inMilliseconds.remainder(1000).toString().padLeft(3, '0');
  logger.info('$message completed in $countS.${countMs}s');
  watch.stop();
}
