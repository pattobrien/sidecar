import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart' as p;

part 'analysis_errors.freezed.dart';

@freezed
class AnalyzedFile with _$AnalyzedFile {
  const AnalyzedFile._();
  const factory AnalyzedFile(
    ContextRoot contextRoot,
    String path,
  ) = _AnalyzedFile;

  bool get isDartFile => p.extension(path) == '.dart';
}
