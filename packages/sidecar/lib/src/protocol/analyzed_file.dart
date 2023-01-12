import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart' as p;

import '../utils/utils.dart';

part 'analyzed_file.freezed.dart';
part 'analyzed_file.g.dart';

/// Represents a file that is within some context currently under analysis.
///
/// This was created to be type-safe.
@freezed
@immutable
class AnalyzedFile with _$AnalyzedFile {
  const factory AnalyzedFile(
    Uri fileUri, {
    required Uri contextRoot,
  }) = _AnalyzedFile;

  const AnalyzedFile._();

  /// Create AnalyzedFile from json.
  factory AnalyzedFile.fromJson(Map<String, dynamic> json) =>
      _$AnalyzedFileFromJson(json);

  /// Absolute file path
  String get path => fileUri.toFilePath();

  /// File path relative to contextRoot
  String get relativePath => p.relative(path, from: contextRoot.toFilePath());

  /// Check if file ends in ```.dart```
  bool get isDartFile => p.extension(path) == '.dart';

  /// Check if file is ```sidecar.yaml``` file at context root
  bool get isSidecarYamlFile => relativePath == kSidecarYaml;
}
