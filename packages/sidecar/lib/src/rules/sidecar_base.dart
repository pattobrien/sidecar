// ignore_for_file: use_setters_to_change_properties

import 'dart:async';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/results.dart' hide AnalysisResult;
import 'package:analyzer/dart/analysis/session.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:glob/glob.dart';
import 'package:riverpod/riverpod.dart';
import 'package:source_span/source_span.dart';
import 'package:yaml/yaml.dart';

import '../analyzer/ast/ast.dart';
import '../analyzer/results/results.dart';
import '../configurations/builders/builders.dart';
import 'typedefs.dart';

enum SidecarBaseType { lint, assist }

abstract class SidecarBase {
  String get code;
  LintPackageId get packageName;

  MapDecoder? get jsonDecoder => null;

  @mustCallSuper
  List<SidecarConfigException>? get errors => _errors;

  @mustCallSuper
  Object get configuration => _configuration;

  late Ref ref;
  late Object _configuration;
  final List<SidecarConfigException> _errors = [];

  late List<SidecarAnnotatedNode> _annotatedNodes;
  List<SidecarAnnotatedNode> get annotatedNodes => _annotatedNodes;

  List<Glob>? get includes => null;

  void registerNodeProcessors(NodeLintRegistry registry) {}

  void update({
    List<SidecarAnnotatedNode> annotatedNodes = const [],
  }) {
    _annotatedNodes = annotatedNodes;
  }

  void initialize({
    required Ref ref,
    required SourceSpan lintNameSpan,
    required YamlMap? configurationContent,
    List<SidecarAnnotatedNode> annotatedNodes = const [],
  }) {
    this.ref = ref;
    _annotatedNodes = annotatedNodes;
    if (jsonDecoder != null) {
      if (configurationContent == null) {
        //TODO: need to handle this
        // final error = SidecarLintPackageException(
        //   sourceSpan: lintNameSpan,
        //   message: '$code error: empty configuration',
        // );
        // _errors.add(error);
      } else {
        try {
          _configuration = jsonDecoder!(configurationContent);
        } on SidecarAggregateException catch (e) {
          _errors.addAll(e.exceptions);
        } catch (e, stackTrace) {
          rethrow;
          // final error = SidecarLintPackageException(
          // );
          // _errors.add(error);
        }
      }
    }
  }

  //TODO: can we remove the future here?
  Future<List<DartAnalysisResult>> computeDartAnalysisResults(
    ResolvedUnitResult unit,
  ) =>
      Future.value([]);

  //TODO: can we remove the future here?
  Future<List<AnalysisResult>> computeYamlAnalysisResults(
    YamlMap yamlMap,
  ) =>
      Future.value([]);

  Future<List<AnalysisResult>> computeGenericAnalysisResults(
    AnalysisContext analysisContext,
    String path,
  ) =>
      Future.value([]);

  Future<List<EditResult>> computeSourceChanges(
    AnalysisSession session,
    AnalysisResult result,
  ) =>
      Future.value(<EditResult>[]);
}
