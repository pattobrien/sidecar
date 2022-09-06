import 'package:analyzer/dart/ast/ast.dart';

import 'package:riverpod/riverpod.dart';

import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;

import '../reporter/i_assist_reporter.dart';
import 'requested_code_edit.dart';

abstract class CodeEdit {
  CodeEdit(this.ref);

  String get id;
  String get message;
  Map<dynamic, dynamic> get yamlConfig => {};

  final ProviderContainer ref;

  late ICodeEditReporter reporter;

  //TODO: lets try an architecture without a node registry
  // void registerNodeProcessors(NodeLintRegistry registry);

  void generateReport(AstNode? node) {
    if (node != null) {
      reporter.reportEdit(node, this);
    }
  }

  Future<plugin.PrioritizedSourceChange> computeSourceChange(
    RequestedCodeEdit requestedCodeEdit,
  );
}
