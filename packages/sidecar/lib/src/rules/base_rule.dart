// ignore_for_file: use_setters_to_change_properties

import 'package:analyzer/dart/analysis/results.dart' hide AnalysisResult;
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glob/glob.dart';
import 'package:source_span/source_span.dart';

import '../../context/context.dart';
import '../analyzer/ast/ast.dart';
import '../analyzer/ast/registered_rule_visitor.dart';
import '../analyzer/context/rule_scope.dart';
import '../configurations/sidecar_spec/sidecar_spec.dart';
import '../protocol/protocol.dart';
import '../utils/utils.dart';
import 'lint_severity.dart';
import 'rules.dart';

/// Base class for constructing any Sidecar rule.
@internal
mixin BaseRule {
  /// Identification for a particular Sidecar rule
  RuleCode get code;

  /// Set default includes for a particular rule.
  ///
  /// Can be overridden in a SidecarSpec file.
  List<Glob>? get includes => null;

  /// Set default excludes for a particular rule.
  ///
  /// Can be overridden in a SidecarSpec file.
  List<Glob>? get excludes => null;

  /// SidecarSpec rule configuration for the active project
  RuleOptions? get ruleOptions =>
      _context.sidecarSpec.getConfigurationForCode(code);

  /// SidecarSpec rule package configuration for the active project
  PackageOptions? get packageOptions =>
      _context.sidecarSpec.getPackageConfigurationForCode(code);

  SidecarContext get context => _context;

  /// ResolvedUnitResult for a particular file.
  ResolvedUnitResult get unit => _unit;

  /// Define which workspace changes this rule should rebuild for.
  RuleScope get scope => _defaultScope;

  final Set<LintResult> lintResults = {};
  final Set<AssistResult> assistFilterResults = {};

  late ResolvedUnitResult _unit;

  static const _defaultScope = RuleScope();

  late SidecarContext _context;

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
    required SidecarContext context,
  }) {
    _context = context;
  }

  @internal
  void clearResults() {
    lintResults.clear();
    assistFilterResults.clear();
  }

  @internal
  void setUnitContext(
    ResolvedUnitResult unit,
  ) {
    _unit = unit;
    lintResults.clear();
    assistFilterResults.clear();
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

/// Function for creating a rule.
///
/// Constructor is used in the entrypoint generation for SidecarAnalyzer.
typedef SidecarBaseConstructor = BaseRule Function();

/// Display a message, warning, or error in the IDE.
mixin Lint on BaseRule {
  @override
  LintCode get code;
  LintSeverity get defaultSeverity => LintSeverity.info;

  @override
  LintOptions? get ruleOptions =>
      _context.sidecarSpec.getConfigurationForCode(code) as LintOptions?;

  @override
  LintPackageOptions? get packageOptions =>
      _context.sidecarSpec.getPackageConfigurationForCode(code)
          as LintPackageOptions?;

  void _reportSpan(
    SourceSpan span,
    String message, {
    String? correction,
    EditsComputer? editsComputer,
  }) {
    final result = LintResult(
      code: code,
      span: span,
      message: message,
      correction: correction,
      severity: ruleOptions?.severity ?? defaultSeverity,
      editsComputer: editsComputer,
    );
    lintResults.add(result);
  }

  void reportAstNode(
    AstNode node, {
    required String message,
    String? correction,
  }) =>
      _reportSpan(node.toSourceSpan(_unit), message, correction: correction);

  void reportToken(
    Token token, {
    required String message,
    String? correction,
  }) =>
      _reportSpan(token.toSourceSpan(_unit), message, correction: correction);
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
      _reportSpan(node.toSourceSpan(_unit), message,
          correction: correction, editsComputer: editsComputer);

  @override
  void reportToken(
    Token token, {
    required String message,
    String? correction,
    EditsComputer? editsComputer,
  }) =>
      _reportSpan(token.toSourceSpan(_unit), message,
          correction: correction, editsComputer: editsComputer);
}

/// Suggested code edits within a single file.
///
/// For multi-file edits, prefer using Refactorings (TBD).
mixin QuickAssist on BaseRule {
  @override
  AssistCode get code;

  void _reportAssistSourceSpan(
    SourceSpan span, {
    EditsComputer? editsComputer,
  }) {
    final result = AssistResult(
      code: code,
      span: span,
      editsComputer: editsComputer,
    );
    assistFilterResults.add(result);
  }

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

/// Utilities to record a piece of data in a codebase.
mixin Data<T> on BaseRule {
  @override
  DataCode get code;

  final dataResults = <SingleDataResult>{};

  @override
  @internal
  void clearResults() {
    dataResults.clear();
    super.clearResults();
  }

  void reportData(T object) {
    final result = SingleDataResult(code: code, data: object);
    dataResults.add(result);
  }
}
