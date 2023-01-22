// Temporarily ignore ordering
// ignore_for_file: directives_ordering

library sidecar;

// is this needed any more?
export 'package:analyzer/dart/analysis/results.dart' hide AnalysisResult;

export 'rules/rules.dart';
export 'src/configurations/exceptions/exceptions.dart';
export 'src/protocol/analyzer_plugin_exts/analyzer_plugin_exts.dart';
export 'src/protocol/protocol.dart' hide SidecarType;
export 'src/utils/utils.dart';

// Approved public APIs
export 'src/analyzer/ast/ast.dart' show NodeRegistry;
export 'type_checker.dart';
