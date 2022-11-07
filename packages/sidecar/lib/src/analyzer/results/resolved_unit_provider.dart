import 'dart:async';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../utils/logger/logger.dart';
import '../context/context.dart';
import '../plugin/plugin.dart';

part 'resolved_unit_provider.g.dart';

@Riverpod(keepAlive: true)
Future<ResolvedUnitResult?> getResolvedUnitForFile(
  GetResolvedUnitForFileRef ref,
  AnalyzedFile file,
) async {
  final rules = ref.watch(filteredRulesForFileProvider(file));
  if (rules.isEmpty && !file.isSidecarYamlFile) {
    //if there are no rules active for a certain file, then we dont resolve the file
    return Future.value();
  }
  SomeResolvedUnitResult? someUnitResult;
  await report(() async {
    final context = ref.watch(analysisContextForRootProvider(file.context));
    final analysisSession = context.currentSession;
    someUnitResult = await analysisSession.getResolvedUnit(file.path);
  }, 'resolvedUnitProvider');
  final r = someUnitResult is ResolvedUnitResult ? someUnitResult : null;
  return r as ResolvedUnitResult?;
}

Future<void> report(
  Future<void> Function() b,
  String message,
) async {
  final watch = Stopwatch()..start();
  logger.finer(message);
  await b();
  final countS = '${watch.elapsed.inSeconds.remainder(60)}';
  final countMs =
      watch.elapsed.inMilliseconds.remainder(1000).toString().padLeft(3, '0');
  logger.finer('$message completed in $countS.${countMs}s');
  watch.stop();
}
