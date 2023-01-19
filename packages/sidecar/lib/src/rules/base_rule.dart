// ignore_for_file: use_setters_to_change_properties

import 'package:analyzer/dart/analysis/results.dart' hide AnalysisResult;
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';
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

/// Base for all Sidecar Rules.
abstract class Rule extends SimpleAstVisitor<void> with BaseRule {
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
  RuleScope get scope => RuleScope.empty;

  /// Results generated from this Rule instance for a particular file.
  ///
  /// Not to be used in Rule definitions.
  @internal
  final Set<AnalysisResult> results = {};

  late ResolvedUnitResult _unit;

  late SidecarContext _context;

  /// Register all of the visit methods of a Sidecar Rule.
  ///
  /// For example, if you have a Lint rule that visits String Literals, then
  /// you must add the visitor to the NodeRegistry's StringLiteral register:
  /// ```dart
  /// class StringLiterals extends LintRule {
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
  void setConfig({required SidecarContext context}) => _context = context;

  @internal
  void clearResults() => results.clear();

  @internal
  void setUnitContext(
    ResolvedUnitResult unit,
  ) {
    _unit = unit;
    results.clear();
  }

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is BaseRule &&
          const DeepCollectionEquality().equals(other.code, code));

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
    results.add(result);
  }

  void reportLint(
    SyntacticEntity entity, {
    required String message,
    String? correction,
  }) =>
      _reportSpan(entity.toSourceSpan(_unit), message, correction: correction);

  @Deprecated('Use reportLint instead.')
  void reportAstNode(
    AstNode node, {
    required String message,
    String? correction,
  }) =>
      reportLint(node, message: message, correction: correction);

  @Deprecated('Use reportLint instead.')
  void reportToken(
    Token token, {
    required String message,
    String? correction,
  }) =>
      reportLint(token, message: message, correction: correction);
}

/// Suggested code edits for a particular Lint
///
/// To provide code edits without lints, use the Assist mixin.
mixin QuickFix on Lint {
  @override
  void reportLint(
    SyntacticEntity entity, {
    required String message,
    String? correction,
    EditsComputer? editsComputer,
  }) =>
      _reportSpan(
        entity.toSourceSpan(unit),
        message,
        correction: correction,
        editsComputer: editsComputer,
      );

  @override
  @Deprecated('Use reportLint instead.')
  void reportAstNode(
    AstNode node, {
    required String message,
    String? correction,
    EditsComputer? editsComputer,
  }) =>
      reportLint(
        node,
        message: message,
        correction: correction,
        editsComputer: editsComputer,
      );

  @Deprecated('Use reportLint instead.')
  @override
  void reportToken(
    Token token, {
    required String message,
    String? correction,
    EditsComputer? editsComputer,
  }) =>
      reportLint(
        token,
        message: message,
        correction: correction,
        editsComputer: editsComputer,
      );
}

/// Suggested code edits within a single file.
///
/// For multi-file edits, prefer using Refactorings (TBD).
mixin QuickAssist on BaseRule {
  @override
  AssistCode get code;

  void reportAssist(
    SyntacticEntity entity, {
    EditsComputer? editsComputer,
  }) {
    final result = AssistResult(
      code: code,
      span: entity.toSourceSpan(unit),
      editsComputer: editsComputer,
    );
    results.add(result);
  }

  @Deprecated('Use reportAssist instead.')
  void reportAssistForNode(
    AstNode node, {
    @Deprecated('only use EditResult message') String? message,
    EditsComputer? editsComputer,
  }) =>
      reportAssist(node, editsComputer: editsComputer);

  @Deprecated('Use reportAssist instead.')
  void reportAssistForToken(
    Token token, {
    @Deprecated('only use EditResult message') String? message,
    EditsComputer? editsComputer,
  }) =>
      reportAssist(token, editsComputer: editsComputer);
}

/// Utilities to record a piece of data in a codebase.
mixin Data on BaseRule {
  @override
  DataCode get code;

  void reportData(Object data) {
    final result = SingleDataResult(code: code, data: data);
    results.add(result);
  }
}
