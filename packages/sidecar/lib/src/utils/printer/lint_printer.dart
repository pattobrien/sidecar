import 'dart:io';

import 'package:cli_util/cli_logging.dart';
import 'package:path/path.dart' as p;

import '../../protocol/models/models.dart';
import '../../rules/lint_severity.dart';

extension LintResultPrinter on LintResult {
  String prettyPrint() {
    final stringBuffer = StringBuffer();
    final path = sourceUrl.toFilePath();

    final relativePath = p.relative(path, from: Directory.current.path);

    final ansi = Ansi(true);
    final location = '$relativePath:${span.start.line}:${span.start.column}';

    // pad error type string so that it aligns in the terminal nicely
    // we need to do this manually (as opposed to using String.padLeft()),
    // because of the extra characters introduced by ansi
    var lintErrorType = '';
    switch (severity) {
      case LintSeverity.info:
        lintErrorType = '   ${severity.ansi}';
        break;
      case LintSeverity.warning:
        lintErrorType = severity.ansi;
        break;
      case LintSeverity.error:
        lintErrorType = '  ${severity.ansi}';
        break;
    }
    final packageId = '${ansi.green}${code.package}${ansi.none}';
    final lintCode = '${ansi.green}${code.id}${ansi.none}';
    final msg = '${ansi.bold}$message${ansi.none}';
    final corr = correction;
    stringBuffer.writeln(
        '  $lintErrorType • $location • $msg $corr • $packageId.$lintCode');
    return stringBuffer.toString();
  }
}

extension LintResultsPrinter on List<LintResult> {
  String? prettyPrint() {
    if (length == 0) return null;
    if (length == 1) return single.prettyPrint();
    sort();
    final prints = map((e) => e.prettyPrint()).toList();
    return prints.reduce((value, element) => '$value$element');
  }
}
