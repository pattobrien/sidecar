// ignore_for_file: use_setters_to_change_properties

import 'dart:async';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:glob/glob.dart';
import 'package:riverpod/riverpod.dart';
import 'package:yaml/yaml.dart';

import '../../builder.dart';
import '../ast/ast.dart';
import '../configurations/yaml_parsers/yaml_parsers.dart';

abstract class SidecarBase {
  String get code;
  LintPackageId get packageName;

  MapDecoder? get jsonDecoder => null;

  Id get id => Id(id: code, packageId: packageName, type: type);

  IdType get type;

  @mustCallSuper
  List<YamlSourceError>? get errors => _errors;

  @mustCallSuper
  Object get configuration => _configuration;

  late Ref ref;
  late Object _configuration;
  final List<YamlSourceError> _errors = [];

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
        final error = YamlSourceError(
          sourceSpan: lintNameSpan,
          message: '$code error: empty configuration',
        );
        _errors.add(error);
      } else {
        try {
          _configuration = jsonDecoder!(configurationContent);
        } catch (e, stackTrace) {
          final error = YamlSourceError(
            sourceSpan: lintNameSpan,
            message: '$code error: incorrect configuration: $e $stackTrace',
          );
          _errors.add(error);
        }
      }
    }
  }

  //TODO: can we remove the future here?
  FutureOr<List<DartAnalysisResult>> computeDartAnalysisResults(
    ResolvedUnitResult unit,
  ) =>
      [];

  //TODO: can we remove the future here?
  FutureOr<List<AnalysisResult>> computeYamlAnalysisResults(
    YamlMap yamlMap,
  ) =>
      [];

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
