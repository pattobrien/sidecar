import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod/riverpod.dart';

import '../reporter/i_assist_reporter.dart';
import 'requested_code_edit.dart';
import 'typedefs.dart';

abstract class CodeEdit {
  CodeEdit(this.ref);

  String get code;
  String get packageName;

  @mustCallSuper
  Object get configuration => _configuration;

  MapDecoder? get jsonDecoder => null;

  @internal
  final ProviderContainer ref;

  late ICodeEditReporter _reporter;
  late Object _configuration;

  void initialize({
    required Map? configurationContent,
    required ICodeEditReporter reporter,
  }) {
    if (jsonDecoder != null) {
      if (configurationContent == null) {
        throw EmptyConfiguration();
      } else {
        try {
          _configuration = jsonDecoder!(configurationContent);
        } catch (e, stackTrace) {
          throw IncorrectConfiguration(e, stackTrace);
        }
      }
    }
    _reporter = reporter;
  }

  Future<plugin.PrioritizedSourceChange?> computeSourceChange(
    RequestedCodeEdit requestedCodeEdit,
  );

  void generateReport(AstNode? node) {
    if (node != null) _reporter.reportAstNode(node, this);
  }
}
