import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart' as p;

import '../../utils/file_paths.dart';
import 'context.dart';

part 'analyzed_file.freezed.dart';

@freezed

/// Represents a file that is within some context currently under analysis.
///
/// This was created to be type-safe.
class AnalyzedFile with _$AnalyzedFile {
  const factory AnalyzedFile(
    ActiveContextRoot activeRoot,
    Uri fileUri,
  ) = _AnalyzedFile;

  const AnalyzedFile._();

  String get path => fileUri.path;

  bool get isDartFile => p.extension(path) == '.dart';

  bool get isAnalysisOptionsFile => relativePath == kAnalysisOptionsYaml;
  bool get isSidecarYamlFile => relativePath == kSidecarYaml;

  String get relativePath => p.relative(path, from: activeRoot.root.path);
}
