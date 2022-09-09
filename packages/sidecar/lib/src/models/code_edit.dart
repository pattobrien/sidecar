import 'package:analyzer/dart/ast/ast.dart';

import 'package:riverpod/riverpod.dart';

import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;

import '../reporter/i_assist_reporter.dart';
import 'requested_code_edit.dart';

abstract class CodeEdit {
  CodeEdit(this.ref);

  String get code;
  String get message;
  Map<dynamic, dynamic> get yamlConfig => <dynamic, dynamic>{};

  final ProviderContainer ref;

  late ICodeEditReporter reporter;

  Future<plugin.PrioritizedSourceChange> computeSourceChange(
      RequestedCodeEdit requestedCodeEdit);

  void generateReport(AstNode? node) {
    if (node != null) reporter.reportEdit(node, this);
  }
}
