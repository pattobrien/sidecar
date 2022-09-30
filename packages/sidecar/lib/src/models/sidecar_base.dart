import 'dart:async';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/element/element.dart';
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
  late List<ElementAnnotation> annotations;

  List<Glob>? get includes => null;

  void registerNodeProcessors(NodeLintRegistry registry) {}

  void initialize({
    required YamlMap? configurationContent,
    required Ref ref,
    required SourceSpan lintNameSpan,
    List<ElementAnnotation> annotations = const [],
  }) {
    this.ref = ref;
    this.annotations = annotations;
    if (jsonDecoder != null) {
      if (configurationContent == null) {
        final error = YamlSourceError(
          sourceSpan: lintNameSpan,
          message: '$code error: empty configuration',
        );
        _errors.add(error);
        // throw EmptyConfiguration('$code error: empty configuration');
      } else {
        try {
          _configuration = jsonDecoder!(configurationContent);
        } catch (e, stackTrace) {
          final error = YamlSourceError(
            sourceSpan: lintNameSpan,
            message: '$code error: incorrect configuration: $e',
          );
          _errors.add(error);
          // throw IncorrectConfiguration(
          //     '$code error: $e', stackTrace, '$packageName $code');
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
    AnalysisResult result,
  ) =>
      Future.value(<EditResult>[]);
}
