import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';

final activatedLintsProvider = Provider.family<ActivatedLints, ContextRoot>(
  (ref, contextRoot) {
    return ActivatedLints(contextRoot: contextRoot);
  },
);

class ActivatedLints {
  ActivatedLints({required this.contextRoot});

  final ContextRoot contextRoot;

  List<LintRule> lintRules = [];

  void addLint(LintRule rule) => lintRules.add(rule);
  void removeLint(LintRule rule) => lintRules.remove(rule);
}
