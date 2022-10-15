library sidecar;

export 'package:analyzer/dart/analysis/results.dart' hide AnalysisResult;
export 'package:yaml/yaml.dart';

export 'src/analyzer/results/results.dart';
export 'src/analyzer/starter.dart';
export 'src/configurations/builders/builders.dart';
export 'src/configurations/yaml_parsers/yaml_parsers.dart';
export 'src/protocol/protocol.dart';
export 'src/rules/rules.dart';
export 'src/utils/utils.dart';
