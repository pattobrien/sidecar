import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:riverpod/riverpod.dart';

import '../services/log_delegate/log_delegate_base.dart';

final analysisContextsProvider = StateProvider(
  (ref) {
    ref.listenSelf((previous, next) {
      ref.read(logDelegateProvider).sidecarMessage(
          'ISOLATE: analysisContextsProvider - ${next.length} contexts');
    });
    return <AnalysisContext>[];
  },
  dependencies: const [],
);
