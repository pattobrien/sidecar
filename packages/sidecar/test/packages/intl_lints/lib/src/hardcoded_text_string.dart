import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/source/line_info.dart';
import 'package:intl_lints/src/constants.dart';
import 'package:sidecar/sidecar.dart';
import 'package:flutter_analyzer_utils/foundation.dart';

const packageId = 'intl_lints';

class HardcodedTextString extends LintRule {
  static const _id = 'hardcoded_text_string';
  static const _message = 'Avoid any hardcoded Strings in Text widgets';
  static const _correction = 'Prefer to use a translated Intl message instead.';

  @override
  LintCode get code => const LintCode(_id, package: packageId, url: kUri);

  @override
  void initializeVisitor(NodeRegistry registry) {
    registry.addInstanceCreationExpression(this);
  }

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    if (textType.isAssignableFromType(node.staticType)) {
      final textBody = node.argumentList.arguments
          .firstWhere((arg) => arg is! NamedExpression);
      if (textBody is SimpleStringLiteral || textBody is SimpleIdentifier) {
        reportAstNode(textBody, message: _message, correction: _correction);
      }
    }
  }
}

final _ignoreRegex = RegExp(r'//\s*ignore\s*:(.+)$', multiLine: true);
final _ignoreForFileRegex =
    RegExp(r'//\s*ignore_for_file\s*:(.+)$', multiLine: true);

bool isIgnored(LintResult lint, LineInfo lineInfo, String source) {
  // -1 because lines starts at 1 not 0
  final line = lint.span.location.startLine - 1;

  if (line == 0) return false;

  final previousLine = source.substring(
    lineInfo.getOffsetOfLine(line - 1),
    lint.span.location.offset - 1,
  );

  final codeContent = _ignoreRegex.firstMatch(previousLine)?.group(1);
  if (codeContent == null) return false;

  final codes = codeContent.split(',').map((e) => e.trim()).toSet();

  return codes.contains(lint.code.id) || codes.contains('type=lint');
}

Set<String> getAllIgnoredForFileCodes(String source) {
  return _ignoreForFileRegex
      .allMatches(source)
      .map((e) => e.group(1)!)
      .expand((e) => e.split(','))
      .map((e) => e.trim())
      .toSet();
}
