import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart' as p;

import '../../protocol/models/models.dart';
import '../../utils/file_paths.dart';

part 'analyzed_file.freezed.dart';

@freezed

/// Represents a file that is within some context currently under analysis.
///
/// This was created to be type-safe.
class AnalyzedFile with _$AnalyzedFile {
  const factory AnalyzedFile(
    Context context,
    Uri fileUri,
  ) = _AnalyzedFile;

  const AnalyzedFile._();

  String get path => fileUri.path;

  bool get isDartFile => p.extension(path) == '.dart';

  bool get isAnalysisOptionsFile => relativePath == kAnalysisOptionsYaml;
  bool get isSidecarYamlFile => relativePath == kSidecarYaml;

  String get relativePath => p.relative(path, from: context.root.path);
}
