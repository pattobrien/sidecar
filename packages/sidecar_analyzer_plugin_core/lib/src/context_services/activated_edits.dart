import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';

final activatedEditsProvider = Provider.family<ActivatedEdits, ContextRoot>(
    (ref, contextRoot) => ActivatedEdits(contextRoot: contextRoot));

class ActivatedEdits {
  const ActivatedEdits({
    required this.contextRoot,
  }) : codeEdits = const [];

  final ContextRoot contextRoot;

  final List<CodeEdit> codeEdits;

  void addEdit(CodeEdit rule) => codeEdits.add(rule);
  void removeLint(CodeEdit rule) => codeEdits.remove(rule);
}
