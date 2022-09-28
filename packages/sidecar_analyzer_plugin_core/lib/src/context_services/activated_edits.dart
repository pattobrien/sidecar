import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';

final activatedEditsProvider =
    Provider.family<ActivatedEdits, ContextRoot>((ref, contextRoot) {
  return ActivatedEdits(contextRoot: contextRoot);
});

class ActivatedEdits {
  ActivatedEdits({
    required this.contextRoot,
  });

  final ContextRoot contextRoot;

  List<CodeEdit> codeEdits = [];

  void addEdit(CodeEdit rule) => codeEdits.add(rule);
  void removeLint(CodeEdit rule) => codeEdits.remove(rule);
  void clearEdits() => codeEdits.clear();
}
