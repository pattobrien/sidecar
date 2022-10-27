import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart' as p;

import '../../utils/file_paths.dart';
import 'context.dart';

part 'analyzed_file.freezed.dart';

@freezed
class AnalyzedFile with _$AnalyzedFile {
  const factory AnalyzedFile(
    ActiveContextRoot root,
    String path,
  ) = _AnalyzedFile;

  const AnalyzedFile._();

  bool get isDartFile => p.extension(path) == '.dart';

  bool get isAnalysisOptionsFile => relativePath == kAnalysisOptionsYaml;
  bool get isSidecarYamlFile => relativePath == kSidecarYaml;

  String get relativePath => p.relative(path, from: root.root.path);
}
