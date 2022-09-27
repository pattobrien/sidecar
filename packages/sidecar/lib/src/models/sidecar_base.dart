import 'dart:async';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/results.dart' hide AnalysisResult;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glob/glob.dart';
import 'package:riverpod/riverpod.dart';
import 'package:yaml/yaml.dart';

import '../ast/ast.dart';
import '../configurations/yaml_parsers/yaml_parsers.dart';
import 'analysis_result.dart';
import 'edit_result.dart';
import 'models.dart';

// @internal
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

  List<Glob>? get includes => null;

  void registerNodeProcessors(NodeLintRegistry registry) {}

  void initialize({
    required YamlMap? configurationContent,
    required Ref ref,
  }) {
    this.ref = ref;
    if (jsonDecoder != null) {
      if (configurationContent == null) {
        // final error = YamlSourceError(sourceSpan: sourceSpan, message: message);
        // _errors.add(value);
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

  //TODO: can we use SourceChange instead of PrioritizedSourceChange?
  Future<List<EditResult>> computeSourceChanges(
    AnalysisResult result,
  ) =>
      Future.value(<EditResult>[]);
}
