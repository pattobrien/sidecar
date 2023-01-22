library sidecar;

export 'package:analyzer/dart/analysis/results.dart' hide AnalysisResult;

export 'rules/rules.dart';
export 'src/analyzer/ast/ast.dart' hide VisitorSubscription;
export 'src/configurations/exceptions/exceptions.dart';
export 'src/protocol/analyzer_plugin_exts/analyzer_plugin_exts.dart';
export 'src/protocol/protocol.dart' hide SidecarType;
export 'src/utils/utils.dart';

export 'type_checker.dart';
