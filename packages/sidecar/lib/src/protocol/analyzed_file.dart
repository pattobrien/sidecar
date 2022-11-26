import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart' as p;

import '../utils/utils.dart';

part 'analyzed_file.freezed.dart';
part 'analyzed_file.g.dart';

@freezed
@immutable

/// Represents a file that is within some context currently under analysis.
///
/// This was created to be type-safe.
class AnalyzedFile with _$AnalyzedFile {
  const factory AnalyzedFile(
    Uri fileUri, {
    required Uri contextRoot,
  }) = _AnalyzedFile;

  const AnalyzedFile._();

  factory AnalyzedFile.fromContext(
    Uri fileUri, {
    required AnalysisContext context,
  }) =>
      AnalyzedFile(fileUri, contextRoot: context.contextRoot.root.toUri());

  factory AnalyzedFile.fromJson(Map<String, dynamic> json) =>
      _$AnalyzedFileFromJson(json);

  String get path => fileUri.path;

  bool get isDartFile => p.extension(path) == '.dart';

  bool get isAnalysisOptionsFile => relativePath == kAnalysisOptionsYaml;
  bool get isSidecarYamlFile => relativePath == kSidecarYaml;

  String get relativePath => p.relative(path, from: contextRoot.path);
}

@freezed
@immutable
class AnalyzedFileWithContext with _$AnalyzedFileWithContext {
  const factory AnalyzedFileWithContext(
    Uri fileUri, {
    required AnalysisContext context,
  }) = _AnalyzedFileWithContext;

  const AnalyzedFileWithContext._();

  factory AnalyzedFileWithContext.fromFile(
    AnalyzedFile file,
    List<AnalysisContext> contexts,
  ) {
    final context = contexts.contextForPath(file.path)!;
    return AnalyzedFileWithContext(file.fileUri, context: context);
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            (other is AnalyzedFileWithContext) &&
            const DeepCollectionEquality().equals(other.fileUri, fileUri) &&
            const DeepCollectionEquality().equals(
                other.context.contextRoot.root.path,
                context.contextRoot.root.path));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(fileUri),
      const DeepCollectionEquality().hash(context.contextRoot.root.path));

  AnalyzedFile toAnalyzedFile() =>
      AnalyzedFile(fileUri, contextRoot: context.contextRoot.root.toUri());

  String get path => fileUri.path;

  bool get isDartFile => p.extension(path) == '.dart';

  bool get isAnalysisOptionsFile => relativePath == kAnalysisOptionsYaml;
  bool get isSidecarYamlFile => relativePath == kSidecarYaml;

  String get relativePath =>
      p.relative(path, from: context.contextRoot.root.path);
}
