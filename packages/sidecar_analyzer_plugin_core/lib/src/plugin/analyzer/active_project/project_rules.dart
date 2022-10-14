import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/builder.dart';
import 'package:sidecar/sidecar.dart';

import '../../../services/services.dart';
import '../../protocol/protocol.dart';
import '../analyzer.dart';

final lintRulesForFileProvider = Provider.family<List<LintRule>, AnalyzedFile>(
  (ref, analyzedFile) {
    return ref.watch(_filteredRulesProvider(analyzedFile)
        .select((value) => value.whereType<LintRule>().toList()));
  },
  name: 'lintRulesForFileProvider',
  dependencies: [
    _filteredRulesProvider,
  ],
);

final assistRulesForFileProvider =
    Provider.family<List<CodeEdit>, AnalyzedFile>(
  (ref, analyzedFile) {
    return ref.watch(_filteredRulesProvider(analyzedFile)
        .select((value) => value.whereType<CodeEdit>().toList()));
  },
  name: 'assistRulesForFileProvider',
  dependencies: [
    _filteredRulesProvider,
  ],
);

final _activatedRulesProvider =
    Provider.family<List<SidecarBase>, ActiveContextRoot>(
  (ref, root) {
    ref.listenSelf((_, next) => ref
        .read(logDelegateProvider)
        .sidecarMessage('ISOLATE: initializedRules = ${next.length}'));

    final context = ref.watch(activeContextForContextRootProvider(root));
    final ruleConstructors = ref.watch(ruleConstructorProvider);
    final activatedRulesService = ref.watch(activatedRulesServiceProvider);

    return activatedRulesService.initializeRules(
      [], // annotations,
      context.sidecarOptions,
      ruleConstructors,
    );
  },
  name: '_activatedRulesProvider',
  dependencies: [
    activeContextForContextRootProvider,
    activatedRulesServiceProvider,
    ruleConstructorProvider,
    logDelegateProvider,
  ],
);

/// Filter rules based on globs defined in project configuration
final _filteredRulesProvider = Provider.family<List<SidecarBase>, AnalyzedFile>(
  (ref, analyzedFile) {
    final allRules = ref.watch(_activatedRulesProvider(analyzedFile.root));
    final context = ref.watch(activeContextsProvider).contextFor(analyzedFile);
    final sidecarOptions = context.sidecarOptions;

    return allRules
        .where((rule) => _isPathIncludedForRule(
            file: analyzedFile,
            rule: rule,
            projectConfiguration: sidecarOptions))
        .toList();
  },
  name: '_filteredRulesProvider',
  dependencies: [
    activeContextsProvider,
    _activatedRulesProvider,
  ],
);

bool _isPathIncludedForRule({
  required AnalyzedFile file,
  required SidecarBase rule,
  required ProjectConfiguration projectConfiguration,
}) {
  final relativePath = p.relative(file.path, from: file.root.root.path);

  // #1 check explicit LintRule/CodeEdit includes from project config
  final ruleConfig = projectConfiguration.getConfiguration(rule.id);

  if (ruleConfig != null && ruleConfig.includes != null) {
    return ruleConfig.includes!.any((glob) => glob.matches(relativePath));
  }

  // #2 check default LintRule/CodeEdit includes from lint/edit definition
  if (rule.includes != null) {
    return rule.includes!.any((glob) => glob.matches(relativePath));
  }

  // TODO: #3 check explicit LintPackage includes from project config
  // TODO: #4 check default LintPackage includes from LintPackage definition

  // #5 check project configuration
  return projectConfiguration.includes(relativePath);
}
