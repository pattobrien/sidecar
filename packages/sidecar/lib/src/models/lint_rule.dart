// ignore_for_file: implementation_imports

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:ansicolor/ansicolor.dart';
import 'package:cli_util/cli_logging.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glob/glob.dart';
import 'package:riverpod/riverpod.dart';

import '../../sidecar.dart';

abstract class LintRule {
  LintRule(this.ref);

  String get code;
  String get packageName;
  String get message;

  LintRuleType get defaultType => LintRuleType.info;
  String? get url => null;
  List<Glob>? get includes => null;

  @mustCallSuper
  Object get configuration => _configuration;

  MapDecoder? get jsonDecoder => null;

  final ProviderContainer ref;

  late Object _configuration;

  void initialize({required Map? configurationContent}) {
    if (jsonDecoder != null) {
      if (configurationContent == null) {
        throw EmptyConfiguration('$code error: empty configuration');
      } else {
        try {
          _configuration = jsonDecoder!(configurationContent);
        } catch (e, stackTrace) {
          throw IncorrectConfiguration(
              '$code error: $e', stackTrace, '$packageName $code');
        }
      }
    }
  }

  @Deprecated(
      'Moving away from registering node processors. Use computeAnalysisError instead.')
  void registerNodeProcessors(NodeLintRegistry registry) {}

  Future<List<DetectedLint>> computeAnalysisError(
    AnalysisContext analysisContext,
    String path,
  );

  SourceSpan computeLintHighlight(DetectedLint lint) => lint.sourceSpan;

  Future<List<plugin.PrioritizedSourceChange>> computeCodeEdits(
    DetectedLint lint,
  ) =>
      Future.value(<plugin.PrioritizedSourceChange>[]);
}

enum LintRuleType { info, warning, error }

extension LintRuleTypeX on LintRuleType {
  String get coloredNamed {
    // final ansi = AnsiPen();
    final ansi = Ansi(true);
    switch (this) {
      case LintRuleType.info:
        // ansi.white(bold: true);
        // return ansi(name);
        return '${ansi.blue}$name';
      case LintRuleType.warning:
        // ansi.yellow();
        // return ansi(name);
        return '${ansi.yellow}$name';
      case LintRuleType.error:
        // ansi.red();
        // return ansi(name);
        return '${ansi.red}$name';
    }
  }
}

extension LintErrorTypeX on LintRuleType {
  plugin.AnalysisErrorSeverity get analysisError {
    switch (this) {
      case LintRuleType.info:
        return plugin.AnalysisErrorSeverity.INFO;
      case LintRuleType.warning:
        return plugin.AnalysisErrorSeverity.WARNING;
      case LintRuleType.error:
        return plugin.AnalysisErrorSeverity.ERROR;
    }
  }
}
