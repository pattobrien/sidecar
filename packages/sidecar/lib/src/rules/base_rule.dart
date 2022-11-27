// ignore_for_file: use_setters_to_change_properties

import 'package:analyzer/dart/analysis/results.dart' hide AnalysisResult;
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glob/glob.dart';
import 'package:source_span/source_span.dart';

import '../analyzer/ast/ast.dart';
import '../analyzer/ast/general_visitor.dart';
import '../configurations/sidecar_spec/sidecar_spec.dart';
import '../protocol/protocol.dart';
import '../utils/utils.dart';
import 'lint_severity.dart';
import 'rules.dart';

/// Base class for constructing any Sidecar rule.
@internal
mixin BaseRule {
  RuleCode get code;
  List<Glob>? get includes => null;
  List<Glob>? get excludes => null;

  final Set<LintResult> lintResults = {};
  final Set<AssistFilterResult> assistFilterResults = {};
  late ResolvedUnitResult _unit;
  late SidecarSpec sidecarSpec;

  ResolvedUnitResult get unit => _unit;

  /// Register all of the visit methods of a Sidecar Rule.
  ///
  /// For example, if you have a Lint rule that visits String Literals, then
  /// you must add the visitor to the NodeRegistry's StringLiteral register:
  /// ```dart
  /// class StringLiterals extends SidecarAstVisitor with Lint {
  ///   ...
  ///
  ///   @override
  ///   void initializeVisitor(NodeRegistry registry) {
  ///     // add SimpleStringLiteral to registry,
  ///     // otherwise visitStringLiteral() will not be called
  ///     registry.addSimpleStringLiteral(this);
  ///   }
  ///
  ///   @override
  ///   void visitStringLiteral(StringLiteral node) {
  ///     reportAstNode(node,
  ///       message: 'Avoid any hardcoded Strings.',
  ///       correction: 'Use an intl message instead.');
  ///   }
  /// }
  /// ```
  void initializeVisitor(NodeRegistry registry);

  // Rule initialization happens in multiple phases
  // 1. Configuration Phase: triggered on SidecarSpec changes
  // 2. Unit Contex Phase: on every file change
  // 3. Annotation Phase:

  @internal
  void setConfig({
    required SidecarSpec sidecarSpec,
  }) {
    this.sidecarSpec = sidecarSpec;
    // TODO: results should be cleared during the setUnitContext stage
    // lintResults.clear();
    // assistFilterResults.clear();
  }

  @internal
  void setUnitContext(ResolvedUnitResult unit) {
    _unit = unit;
    lintResults.clear();
    assistFilterResults.clear();
  }

  void _reportSourceSpan(
    SourceSpan span,
    String message, {
    String? correction,
    EditsComputer? editsComputer,
  }) {
    if (this is Lint) {
      final thisConfig =
          sidecarSpec.getConfigurationForCode(code) as LintOptions?;
      final result = LintResult(
        rule: code,
        span: span,
        message: message,
        correction: correction,
        severity: thisConfig?.severity ?? (this as Lint).defaultSeverity,
        editsComputer: editsComputer,
      );
      lintResults.add(result);
    } else {
      throw UnimplementedError(
          '_reportAssistSourceSpan should receive QuickAssist rules only.');
    }
  }

  void _reportAssistSourceSpan(
    SourceSpan span, {
    EditsComputer? editsComputer,
  }) {
    if (this is QuickAssist) {
      final result = AssistFilterResult(
        rule: code,
        span: span,
        editsComputer: editsComputer,
      );
      assistFilterResults.add(result);
    } else {
      throw UnimplementedError(
          '_reportAssistSourceSpan should receive QuickAssist rules only.');
    }
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is BaseRule &&
            const DeepCollectionEquality().equals(other.code, code));
  }

  @override
  int get hashCode => Object.hash(
        runtimeType,
        const DeepCollectionEquality().hash(code),
      );
}

/// Display a message, warning, or error in the IDE.
mixin Lint on BaseRule {
  @override
  LintCode get code;
  LintSeverity get defaultSeverity => LintSeverity.info;

  void reportAstNode(
    AstNode node, {
    required String message,
    String? correction,
  }) =>
      _reportSourceSpan(node.toSourceSpan(_unit), message,
          correction: correction);

  void reportToken(
    Token token, {
    required String message,
    String? correction,
  }) =>
      _reportSourceSpan(token.toSourceSpan(_unit), message,
          correction: correction);
}

/// Suggested code edits for a particular Lint
///
/// To provide code edits without lints, use the Assist mixin.
mixin QuickFix on Lint {
  @override
  void reportAstNode(
    AstNode node, {
    required String message,
    String? correction,
    EditsComputer? editsComputer,
  }) =>
      _reportSourceSpan(node.toSourceSpan(_unit), message,
          correction: correction, editsComputer: editsComputer);

  @override
  void reportToken(
    Token token, {
    required String message,
    String? correction,
    EditsComputer? editsComputer,
  }) =>
      _reportSourceSpan(token.toSourceSpan(_unit), message,
          correction: correction, editsComputer: editsComputer);
}

/// Suggested code edits within a single file.
///
/// For multi-file edits, prefer using Refactorings (TBD).
mixin QuickAssist on BaseRule {
  void reportAssistForNode(
    AstNode node, {
    @Deprecated('only use EditResult message') String? message,
    EditsComputer? editsComputer,
  }) =>
      _reportAssistSourceSpan(node.toSourceSpan(_unit),
          editsComputer: editsComputer);

  void reportAssistForToken(
    Token token, {
    @Deprecated('only use EditResult message') String? message,
    EditsComputer? editsComputer,
  }) =>
      _reportAssistSourceSpan(token.toSourceSpan(_unit),
          editsComputer: editsComputer);
}
