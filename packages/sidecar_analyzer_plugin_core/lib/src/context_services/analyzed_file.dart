import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart' as p;

part 'analyzed_file.freezed.dart';

@freezed
class AnalyzedFile with _$AnalyzedFile {
  const factory AnalyzedFile(
    ContextRoot contextRoot,
    String path,
  ) = _AnalyzedFile;

  const AnalyzedFile._();

  bool get isDartFile => p.extension(path) == '.dart';

  String get relativePath => p.relative(path, from: contextRoot.root.path);
}
