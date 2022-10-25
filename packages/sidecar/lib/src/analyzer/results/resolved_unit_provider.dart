import 'dart:async';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:riverpod/riverpod.dart';

import '../../utils/logger/logger.dart';
import '../context/context.dart';
import '../plugin/plugin.dart';
import '../server/log_delegate.dart';

final resolvedUnitProvider =
    FutureProvider.family<ResolvedUnitResult?, AnalyzedFile>(
  (ref, file) async {
    SomeResolvedUnitResult? someUnitResult;
    await report(() async {
      final context = ref.watch(activeContextForRootProvider(file.root));
      final analysisSession = context.currentSession;
      someUnitResult = await analysisSession.getResolvedUnit(file.path);
    }, 'resolvedUnitProvider', ref.read(logDelegateProvider));
    final r = someUnitResult is ResolvedUnitResult ? someUnitResult : null;
    return r as ResolvedUnitResult?;
  },
  name: 'resolvedUnitProvider',
  dependencies: [
    activeContextForRootProvider,
    logDelegateProvider,
  ],
);

Future<void> report(
  Future<void> Function() b,
  String message,
  LogDelegateBase delegate,
) async {
  final watch = Stopwatch()..start();
  delegate.sidecarVerboseMessage(message);
  await b();
  final countS = '${watch.elapsed.inSeconds.remainder(60)}';
  final countMs =
      watch.elapsed.inMilliseconds.remainder(1000).toString().padLeft(3, '0');
  delegate.sidecarVerboseMessage('$message completed in $countS.${countMs}s');
  watch.stop();
}
