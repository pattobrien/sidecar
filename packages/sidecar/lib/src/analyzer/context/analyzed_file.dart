import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart' as p;

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

  bool get isAnalysisOptionsFile => relativePath == 'analysis_options.yaml';
  bool get isSidecarYamlFile => relativePath == 'sidecar.yaml';

  String get relativePath => p.relative(path, from: root.root.path);
}
